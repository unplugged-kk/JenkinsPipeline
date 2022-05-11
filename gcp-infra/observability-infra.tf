#GCP Auth Setup

provider "google" {
  project     = "sylerseclearn2022-348606"
  region      = "us-west1"
}

#Creation of VPC NW 

resource "google_compute_network" "vpc_network" {
  name = "observability-infra"
  auto_create_subnetworks = "false"
}

#Creation of subnet 

resource "google_compute_subnetwork" "observability-infra-subnet" {
  name          = "observability-subnet1"
  ip_cidr_range = "10.240.0.0/24"

  
  region        = "us-west1"
  network       = google_compute_network.vpc_network.id
}

#Creation of firewall rules

#Internal firewall create
resource "google_compute_firewall" "observability-fw-int" {
  name    = "observability-fw-allow-internal"
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

resource "google_compute_firewall" "observability-fw-ext" {
  name    = "observability-fw-allow-external"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22","443","80","8080","9090","9000-10000","30000-40000","5601","6443"]
  }

  source_ranges = ["0.0.0.0/0"]
}


# Public IP Creation#

resource "google_compute_address" "vm_static_ip_master" {
  name = "observability-master-ip"
}

resource "google_compute_address" "vm_static_ip_worker1" {
  name = "observability-worker1-ip"
}

resource "google_compute_address" "vm_static_ip_worker2" {
  name = "observability-worker2-ip"
}

# Public IP Output #

output "out_master_pub_ip" {
    value = google_compute_address.vm_static_ip_master.address
}

output "out_worker1_pub_ip" {
    value = google_compute_address.vm_static_ip_worker1.address
}

output "out_worker2_pub_ip" {
    value = google_compute_address.vm_static_ip_worker2.address
}

#Creation of observability-infra Nodes

#observability-master-0

resource "google_compute_instance" "master-0" {
  name         = "observability-master"
  machine_type = "e2-small"
  zone         = "us-west1-c"
  can_ip_forward       = true
  tags = ["observability-infra"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-focal-v20220419"
      size = 20
    }
  }
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  metadata = {
   ssh-keys = "kishorekumarbehera:${file("~/.ssh/id_rsa.pub")}"
 }

  network_interface {
    network = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.observability-infra-subnet.name
    network_ip = "10.240.0.10"
    access_config {
      nat_ip = google_compute_address.vm_static_ip_master.address
    }
  }
}

#observability-worker1

resource "google_compute_instance" "worker-1" {
  name         = "observability-worker1"
  machine_type = "e2-medium"
  zone         = "us-west1-c"
  can_ip_forward       = true
  tags = ["observability-infra"]

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-focal-v20220419"
      size = 30
    }
  }
  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }

  metadata = {
   ssh-keys = "kishorekumarbehera:${file("~/.ssh/id_rsa.pub")}"
 }

  network_interface {
    network = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.observability-infra-subnet.name
    network_ip = "10.240.0.11"
    access_config {
      nat_ip = google_compute_address.vm_static_ip_worker1.address
    }
  }
}

 #observability-worker2

 resource "google_compute_instance" "worker-2" {
   name         = "observability-worker2"
   machine_type = "e2-medium"
   zone         = "us-west1-c"
   can_ip_forward       = true
   tags = ["observability-infra"]

   boot_disk {
     initialize_params {
       image = "ubuntu-os-cloud/ubuntu-2004-focal-v20220419"
       size = 30
     }
   }
   scheduling {
     automatic_restart   = true
     on_host_maintenance = "MIGRATE"
   }

   metadata = {
    ssh-keys = "kishorekumarbehera:${file("~/.ssh/id_rsa.pub")}"
  }

   network_interface {
     network = google_compute_network.vpc_network.name
     subnetwork = google_compute_subnetwork.observability-infra-subnet.name
     network_ip = "10.240.0.12"
     access_config {
       nat_ip = google_compute_address.vm_static_ip_worker2.address
     }
   }
 }


