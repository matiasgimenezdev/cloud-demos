variable "credentials_file_path" {
  type    = string
  default = "credentials.json"
}

variable "project_id" {
  type    = string
  default = "braided-complex-416718"
}

variable "region" {
  type    = string
  default = "us-east1"
}

variable "zone" {
  type    = string
  default = "us-east1-b"
}

variable "nodes" {
  type    = number
  default = 1
}

variable "base_image" {
  type    = string
  default = "nginx-docker-1714314905" # ubuntu-os-cloud/ubuntu-2004-lts
}
