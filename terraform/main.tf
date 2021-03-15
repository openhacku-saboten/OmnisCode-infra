provider "google" {
  credentials = file("./cred.json")
  region      = "asia-northeast1"
  zone        = "asia-northeast1-c"
  project = var.project-name
}

resource "google_compute_address" "static" {
  name = "ipv4-address"
}

resource "google_compute_instance" "omniscode-server" {
  name         = "omniscode-server"
  machine_type = "g1-small"
  zone         = "asia-northeast1-c"
  allow_stopping_for_update = true
  tags = [ "omniscode-port" ]
  boot_disk {
    initialize_params {
      size = 30
      image = "ubuntu-os-cloud/ubuntu-minimal-2004-focal-v20210223a"
    }
  }
  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }
  metadata = {
    ssh-keys = "${var.username}:${file("~/.ssh/omniscode-gcp.pub")}"
  }
}

# resource "google_compute_firewall" "omniscode-port" {
#   name    = "omniscode-port"
#   network = "default"

#   allow {
#     protocol = "tcp"
#     ports    = ["25565"]
#   }

#   // Allow traffic from everywhere to instances with an http-server tag
#   source_ranges = ["0.0.0.0/0"]
#   target_tags   = ["omniscode-port"]
# }

output "ip" {
  value = google_compute_instance.omniscode-server.network_interface.0.access_config.0.nat_ip
}
