resource "google_compute_network" "gocron" {
  name    = "${var.network_name}-${terraform.workspace}"
  project = "${var.project}"
  auto_create_subnetworks = "false"
}


resource "google_compute_subnetwork" "gocron" {
  name          = "${var.subnetwork_name}-${terraform.workspace}"
  project       = "${var.project}"
  ip_cidr_range = "${var.cidr}"
  network       = "${google_compute_network.gocron.self_link}"
  region        = "${var.region}"
}


resource "google_compute_firewall" "frontend" {
  name    = "front-firewall-${terraform.workspace}"
  project = "${var.project}"
  network = "${google_compute_network.gocron.name}"

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_tags = ["gocron-front"]
}


resource "google_compute_firewall" "ssh" {
  name    = "ssh-${terraform.workspace}"
  project = "${var.project}"
  network = "${google_compute_network.gocron.name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_tags = ["ssh"]
}
