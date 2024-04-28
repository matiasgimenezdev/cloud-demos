terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=4.60.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 3.0" // Puedes especificar la versión o el rango de versiones que deseas utilizar
    }
  }

  required_version = ">= 1.4.5"
}

provider "google" {
  credentials = file(var.credentials_file_path)
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}


provider "tls" {
  // no config needed
}

resource "google_project_service" "cloud_resource_manager" {
  service            = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "compute" {
  service            = "compute.googleapis.com"
  disable_on_destroy = false
}

