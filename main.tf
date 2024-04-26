resource "google_compute_instance" "bastion_host" {
  name         = "bastion-host"
  machine_type = "e2-micro"
  zone          = "us-central1-a"

  # VPC network configuration
  network_interface {
    network = "your-vpc-network"
  }
}

resource "google_compute_firewall" "bastion_host_ssh" {
  name   = "allow-ssh-bastion-host"
  network = "your-vpc-network"

  allow {
    protocol = "tcp"
    ports    = ["22"]
    sources  = ["your-ip-address/cidr"]
  }

  source_ranges = ["0.0.0.0/0"]  # Block by default, allow SSH only from your IP
}

resource "google_compute_instance" "web_server" {
  name         = "web-server"
  machine_type = "e2-micro"
  zone          = "us-central1-a"

  # VPC network configuration
  network_interface {
    network = "your-vpc-network"
  }
}

resource "google_compute_firewall" "web_server_http" {
  name   = "allow-http-web-server"
  network = "your-vpc-network"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]  # Allow HTTP and HTTPS
  }

  source_ranges = ["0.0.0.0/0"]  # Allow access from anywhere for demo purposes
}
