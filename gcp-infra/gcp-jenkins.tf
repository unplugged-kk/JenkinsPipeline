#GCP Auth Setup

provider "google" {
  project     = "gcp-cert-prep-initial"
  region      = "us-west1"
}

#Creation of VPC NW 

resource "google_compute_network" "vpc_network" {
  name = "jenkins-gcp-infra"
  auto_create_subnetworks = "false"
}

#Creation of subnet 

resource "google_compute_subnetwork" "jenkins-gcp-infra-subnet" {
  name          = "jenkins-gcp-subnet1"
  ip_cidr_range = "10.240.0.0/24"

  
  region        = "us-west1"
  network       = google_compute_network.vpc_network.id
}

#Creation of firewall rules

#Internal firewall create
resource "google_compute_firewall" "jenkins-gcp-fw-int" {
  name    = "jenkins-gcp-fw-allow-internal"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["10.240.0.0/24"]
}

#External firewall create 

resource "google_compute_firewall" "jenkins-gcp-fw-ext" {
  name    = "jenkins-gcp-fw-allow-external"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

#Creation of jenkins-gcp-infra Nodes

#jenkins-gcp-master-0

resource "google_compute_instance" "master-0" {
  name         = "jenkins-gcp-master-0"
  machine_type = "e2-standard-4"
  zone         = "us-west1-c"
  can_ip_forward       = true
  tags = ["jenkins-gcp-infra"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7-v20200714"
      size = 100
    }
  }
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  metadata = {
   ssh-keys = "kishore:${file("~/.ssh/id_rsa.pub")}"
 }

  network_interface {
    network = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.jenkins-gcp-infra-subnet.name
    network_ip = "10.240.0.10"
    access_config {
    }
  }
}

#jenkins-gcp-slave-0

resource "google_compute_instance" "slave-0" {
  name         = "jenkins-gcp-slave-0"
  machine_type = "e2-small"
  zone         = "us-west1-c"
  can_ip_forward       = true
  tags = ["jenkins-gcp-infra"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7-v20200714"
      size = 50
    }
  }
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  metadata = {
   ssh-keys = "kishore:${file("~/.ssh/id_rsa.pub")}"
 }

  network_interface {
    network = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.jenkins-gcp-infra-subnet.name
    network_ip = "10.240.0.11"
    access_config {
    }
  }
}

#jenkins-gcp-slave-1

resource "google_compute_instance" "slave-1" {
  name         = "jenkins-gcp-slave-1"
  machine_type = "e2-small"
  zone         = "us-west1-c"
  can_ip_forward       = true
  tags = ["jenkins-gcp-infra"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7-v20200714"
      size = 50
    }
  }
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  metadata = {
   ssh-keys = "kishore:${file("~/.ssh/id_rsa.pub")}"
 }

  network_interface {
    network = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.jenkins-gcp-infra-subnet.name
    network_ip = "10.240.0.12"
    access_config {
    }
  }
}


