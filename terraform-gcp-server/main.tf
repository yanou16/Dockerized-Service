provider "google" {
  project = "gen-lang-client-0131974400"
  region  = "europe-west1"
  zone    = "europe-west1-b"
}

resource "google_compute_instance" "vm_instance" {
  name         = "nodejs-server"
  machine_type = "e2-micro"
  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size  = 10
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Cela attribue une IP externe
    }
  }

  metadata_startup_script = <<-EOT
    #!/bin/bash
    apt-get update
    apt-get install -y curl
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
    apt-get install -y nodejs
    
    # Installation de Docker
    apt-get install -y apt-transport-https ca-certificates gnupg lsb-release
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt-get update
    apt-get install -y docker-ce docker-ce-cli containerd.io
    
    # Permettre à l'utilisateur de gérer Docker sans sudo
    usermod -aG docker $(whoami)
    
    mkdir -p /app
  EOT

  tags = ["http-server", "https-server"]
}