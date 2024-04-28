# Creds and default location
variable "credentials" {
  default = "./credentials.json" // Cambiar con tu archivo .json de la cuenta de servicio
}

variable "project" {
  default = "braided-complex-416718" // Tu ID de proyecto de GCP
}

variable "region" {
  default = "us-east1"
}

variable "zone" {
  default = "us-east1-b"
}

# Instance Template
variable "prefix" {
  default = "nginx-"
}

variable "desc" {
  default = "This template is used to create nginx server instances."
}

variable "tags" {
  default = "webserver"
}

variable "desc_inst" {
  default = "nginx Web server instance"
}

variable "machine_type" {
  default = "n1-standard-1"
}

variable "source_image" {
  default = "custom-golden-1714341789" // Esta es la etiqueta de familia usada al construir la Imagen Dorada con Packer
}

variable "network" {
  default = "default"
}

# Managed Instance Group
variable "rmig_name" {
  default = "nginx-rmig"
}

variable "base_instance_name" {
  default = "custom-nginx"
}

variable "target_size" {
  default = "3"
}

# Healthcheck
variable "hc_name" {
  default = "nginx-healthcheck"
}

variable "hc_port" {
  default = "80"
}

# Backend
variable "be_name" {
  default = "http-backend"
}

variable "be_protocol" {
  default = "HTTP"
}

variable "be_port_name" {
  default = "http"
}

variable "be_timeout" {
  default = "10"
}

variable "be_session_affinity" {
  default = "NONE"
}

# RMIG Autoscaler
variable "rmig_as_name" {
  default = "rmig-as"
}

# Global Forwarding Rule
variable "gfr_name" {
  default = "website-forwarding-rule"
}

variable "gfr_portrange" {
  default = "80"
}

variable "thp_name" {
  default = "http-proxy"
}

variable "urlmap_name" {
  default = "http-lb-url-map"
}

# Firewall Rules
variable "fwr_name" {
  default = "allow-http-https"
}
