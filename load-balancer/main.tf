# Define local variables. They can only be accessed on this module.
locals {
  # Define Linux-specific metadata for virtual machine instances.
  linux_metadata = templatefile("${path.module}/scripts/linux-metadata.tpl", {})
}

# Collects information about the currently authenticated user.
data "google_client_openid_userinfo" "me" {}

# Configures the provider for Google Cloud Platform (GCP) resources in Terraform.
provider "google" {
  credentials = var.credentials
  project     = var.project
  region      = var.region
}

# Generates a new SSH key
resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

#  Saves the generated key to a local file with appropriate permissions.
resource "local_file" "ssh_private_key_pem" {
  content         = tls_private_key.ssh.private_key_pem
  filename        = "${path.module}/.ssh/google_compute_engine"
  file_permission = "0600"
}

# Configures a backend service and an HTTP health check for virtual machine instances.
#
# A Backend Service is a resource that defines how incoming requests directed to a specific application or service are handled. 
# It is responsible for routing incoming traffic to one or more virtual machine (VM) instances or instance groups. 
# Backend services are commonly used in load-balancing scenarios for the distribution of incoming requests across multiple instances.
resource "google_compute_backend_service" "rbs" {
  name             = var.be_name
  port_name        = var.be_port_name
  protocol         = var.be_protocol
  timeout_sec      = var.be_timeout
  session_affinity = var.be_session_affinity

  backend {
    group = google_compute_region_instance_group_manager.rmig.instance_group
  }

  health_checks = ["${google_compute_http_health_check.default.self_link}"]
}

# Health Check is a feature used to monitor the status and health of the instances or services behind a backend service.
# If an instance fails its health check, it's automatically removed from the pool of available instances, ensuring that traffic 
# is only directed to healthy instances.
resource "google_compute_http_health_check" "default" {
  name               = var.hc_name
  request_path       = "/"
  check_interval_sec = 1
  timeout_sec        = 1
}

# Configures a regional managed instance group for virtual machine instances.
# There are multiple instances located in different zones within a particular region.
resource "google_compute_region_instance_group_manager" "rmig" {
  name               = var.rmig_name
  base_instance_name = var.base_instance_name
  region             = var.region # Inside this particular region
  target_size        = 1

  named_port {
    name = "http"
    port = 80
  }

  named_port {
    name = "https"
    port = 443
  }

  auto_healing_policies {
    health_check      = google_compute_http_health_check.default.self_link
    initial_delay_sec = 300
  }
  version {
    name              = "deployed-version"
    instance_template = google_compute_instance_template.cit.self_link
  }

}

# Creates an instance template for virtual machine instances.
resource "google_compute_instance_template" "cit" {
  name_prefix          = var.prefix
  description          = var.desc
  project              = var.project
  region               = var.region
  tags                 = ["${var.tags}"]
  instance_description = var.desc_inst
  machine_type         = var.machine_type
  # Whether to allow sending and receiving of packets with non-matching source or destination IPs. This defaults to false.
  can_ip_forward       = false 

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  # Create a new boot disk from an image (Let's use one created by Packer)
  disk {
    source_image = var.source_image
    auto_delete  = true
    boot         = true
  }

  metadata_startup_script = local.linux_metadata

  metadata = {
    ssh-keys = "${split("@", data.google_client_openid_userinfo.me.email)[0]}:${tls_private_key.ssh.public_key_openssh}"
  }

  network_interface {
    network = var.network
    #
    # Give a Public IP to instance(s)
    access_config {
      // Ephemeral IP
    }
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Configures a health check for virtual machine instances.
resource "google_compute_health_check" "default" {
  name               = var.hc_name
  check_interval_sec = 1
  timeout_sec        = 1

  tcp_health_check {
    port = var.hc_port
  }
}

# Configures an auto-scaler for the regional managed instance group (MIG).
resource "google_compute_region_autoscaler" "cras" {
  name   = "test-autoscaler"
  region = var.region
  target = google_compute_region_instance_group_manager.rmig.self_link

  autoscaling_policy {
    max_replicas    = 8
    min_replicas    = 1
    cooldown_period = 30

    cpu_utilization {
      target = 0.72
    }
  }
}

# Configures a global forwarding rule for the load balancer.
resource "google_compute_global_forwarding_rule" "gfr" {
  name       = var.gfr_name
  target     = google_compute_target_http_proxy.thp.self_link
  port_range = var.gfr_portrange
}

resource "google_compute_target_http_proxy" "thp" {
  name    = var.thp_name
  url_map = google_compute_url_map.urlmap.self_link
}

resource "google_compute_url_map" "urlmap" {
  name            = var.urlmap_name
  default_service = google_compute_backend_service.rbs.self_link
}

# Configures firewall rules to allow traffic to specified ports.
resource "google_compute_firewall" "default" {
  name    = "${var.network}-${var.fwr_name}"
  network = var.network
  project = var.project

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
  source_ranges = ["0.0.0.0/32"]
}
