// variables
variable "project_name" {
  default = "artjoint"
} 
variable "region" {
    default = "us-central1"
}
variable "region_zone" {
  default = "us-central1-c"
}

variable "account_file_path" {
  default = "service_account_key.json"
}

provider "google" {
    region = "${var.region}"
    project = "${var.project_name}"
    credentials = "${file(var.account_file_path)}"
}

resource "google_compute_http_health_check" "default" {
    name = "tf-www-basic-check"
    request_path = "/"
    check_interval_sec = 1
    healthy_threshold = 1
    unhealthy_threshold = 10
    timeout_sec = 1
}

resource "google_compute_target_pool" "default" {
    name = "tf-www-target-pool"
    health_checks = ["${google_compute_http_health_check.default.name}"]
}

resource "google_compute_forwarding_rule" "default" {
    name = "tf-www-forwarding-rule"
    target = "${google_compute_target_pool.default.self_link}"
    port_range = "80"
}

resource "google_compute_instance_template" "www" {
    name = "tf-www"
    machine_type = "n1-standard-1"
    tags = ["www-node"]

    disk {
        source_image = "ubuntu-os-cloud/ubuntu-1204-precise-v20150625"
        auto_delete = true
        boot = true
    }

    network_interface {
        network = "default"
        access_config {
            # Ephemeral
        }
    }

    service_account {
        scopes = ["https://www.googleapis.com/auth/compute.readonly"]
    }
}

resource "google_compute_instance_group_manager" "default" {
    name = "tf-www-gm"
    target_pools = ["${google_compute_target_pool.default.self_link}"]
    base_instance_name = "tf-www"
    zone = "${var.region_zone}"

    version {
    instance_template  = "${google_compute_instance_template.www.self_link}"
  }
}

resource "google_compute_autoscaler" "default" {
    name = "tf-www-autoscaler"
    zone = "${var.region_zone}"
    target = "${google_compute_instance_group_manager.default.self_link}"

    autoscaling_policy {
        max_replicas = 5
        min_replicas = 3
        cooldown_period = 15
        cpu_utilization {
            target = 0.7
        }
    }
}

resource "google_compute_firewall" "default" {
    name = "tf-www-firewall"
    network = "default"

    allow {
        protocol = "tcp"
        ports = ["80"]
    }

    source_ranges = ["0.0.0.0/0"]
    target_tags = ["www-node"]
}
