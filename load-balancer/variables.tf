# Creds and default location
variable "credentials" {
  type    = string
  default = "./credentials.json" // Cambiar con tu archivo .json de la cuenta de servicio
}

variable "project" {
  type    = string
  default = "braided-complex-416718" // Tu ID de proyecto de GCP
}

variable "region" {
  type    = string
  default = "us-east1"
}

variable "zone" {
  type    = string
  default = "us-east1-b"
}

# Instance Template
variable "prefix" {
  type    = string
  default = "nginx-"
}

variable "desc" {
  type    = string
  default = "This template is used to create nginx server instances."
}

variable "tags" {
  type    = string
  default = "webserver"
}

variable "desc_inst" {
  type    = string
  default = "nginx Web server instance"
}

variable "machine_type" {
  type    = string
  default = "n1-standard-1"
}

variable "source_image" {
  type    = string
  default = "custom-golden-1714341789" // Esta es la etiqueta de familia usada al construir la Imagen Dorada con Packer
}

variable "network" {
  type    = string
  default = "default"
}

# Managed Instance Group
variable "rmig_name" {
  type    = string
  default = "nginx-rmig"
}

variable "base_instance_name" {
  type    = string
  default = "custom-nginx"
}

variable "target_size" {
  type    = string
  default = "3"
}

# Healthcheck
variable "hc_name" {
  type    = string
  default = "nginx-healthcheck"
}

variable "hc_port" {
  type    = string
  default = "80"
}

# Backend
variable "be_name" {
  type    = string
  default = "http-backend"
}

variable "be_protocol" {
  type    = string
  default = "HTTP"
}

variable "be_port_name" {
  type    = string
  default = "http"
}

variable "be_timeout" {
  type    = string
  default = "10"
}

variable "be_session_affinity" {
  type    = string
  default = "NONE"
}

# RMIG Autoscaler
variable "rmig_as_name" {
  type    = string
  default = "rmig-as"
}

# Global Forwarding Rule
variable "gfr_name" {
  type    = string
  default = "website-forwarding-rule"
}

variable "gfr_portrange" {
  type    = string
  default = "80"
}

variable "thp_name" {
  type    = string
  default = "http-proxy"
}

variable "urlmap_name" {
  type    = string
  default = "http-lb-url-map"
}

# Firewall Rules
variable "fwr_name" {
  type    = string
  default = "allow-http-https"
}
