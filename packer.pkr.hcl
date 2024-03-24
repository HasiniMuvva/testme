packer {
  required_plugins {
    googlecompute = {
      version = ">= 1.1.4"
      source  = "github.com/hashicorp/googlecompute"
    }
  }
}

source "googlecompute" "centos" {
  project_id         = "electric-clone-412119"  # Enclose the project_id value in double quotes
  source_image_family = "centos-stream-8"
  zone               = "us-central1-a"
  ssh_username       = "centos"
  image_name         = "custom-image-{{timestamp}}"
}

build {
  sources = ["source.googlecompute.centos"]

  provisioner "file" {
    source      = "application.zip"
    destination = "/tmp/application.zip"
  }

  provisioner "file" {
    source      = "nodeinstallement.sh"
    destination = "/tmp/nodeinstallement.sh"
  }
  
  provisioner "file" {
    source      = "permissions.sh"
    destination = "/tmp/permissions.sh"
  }

  provisioner "file" {
    source      = "nodeindex.sh"
    destination = "/tmp/nodeindex.sh"
  }

  provisioner "file" {
    source      = "ops_agent_install.sh"
    destination = "/tmp/ops_agent_install.sh"
  }

  provisioner "file" {
    source      = "ops_config.sh"
    destination = "/tmp/ops_config.sh"
  }

  provisioner "shell" {
    script = "nodeinstallement.sh"
  }

  provisioner "shell" {
    script = "permissions.sh"
  }

  provisioner "shell" {
    script = "ops_agent_install.sh"
  }

  provisioner "shell" {
    script = "ops_config.sh"
  }
  
  provisioner "shell" {
    script = "nodeindex.sh"
  }
   
}