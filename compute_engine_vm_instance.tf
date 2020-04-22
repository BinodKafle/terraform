// variables
variable "project" {} 
variable "region" {
    default = "us-central1"
}
variable "zone" {
  default = "us-central1-c"
}


// provider
provider "google" {
  credentials = file("service_account_key.json")
  project = var.project
  region = var.region
}

resource "google_compute_instance_template" "webserver" {
  name = "standard-webserver"
  machine_type = "n1-standard-1"
  metadata_startup_script = "apt-get update && apt-get install -y nginx"

  network_interface {
      network = "default"
      access_config {}
  }

  disk {
      source_image = "debian-cloud/debian-8"
      auto_delete = true
      boot = true
  }
}
