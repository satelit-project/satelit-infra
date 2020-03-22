variable "access_token" {}
variable "spaces_key" {}
variable "spaces_secret" {}

variable "region" {
  type = string
  default = "nyc1"
}

variable "droplet_size" {
  type = string
  default = "s-1vcpu-1gb"
}

variable "domain" {
  type = string
  default = "shitty.moe"
}

provider "digitalocean" {
  token = var.access_token
  spaces_access_id = var.spaces_key
  spaces_secret_key = var.spaces_secret
}

data "digitalocean_image" "satelit_import" {
  name = "satelit-import"
}

data "digitalocean_ssh_key" "satelit_import" {
  name = "satelit-import-ssh"
}

resource "digitalocean_project" "satelit" {
  name = "Satelit Project"
  description = "Wanna watch something?"
  purpose = "Mobile Application"
  environment = "Production"
  resources = [
    digitalocean_droplet.satelit_import.urn,
    digitalocean_domain.satelit.urn,
    digitalocean_spaces_bucket.junk.urn,
    digitalocean_volume.satelit_import.urn,
  ]
}

resource "digitalocean_droplet" "satelit_import" {
  image = data.digitalocean_image.satelit_import.id
  name = "satelit-import"
  region = var.region
  size = var.droplet_size
  ssh_keys = [data.digitalocean_ssh_key.satelit_import.id]
  backups = true
  monitoring = true
  private_networking = true
}

resource "digitalocean_domain" "satelit" {
  name = var.domain
}

resource "digitalocean_spaces_bucket" "junk" {
  name = "junk"
  region = "nyc3"  # hardcoded becauce of limited availability
  acl = "private"
}

resource "digitalocean_volume" "satelit_import" {
  name = "satelit-import"
  region = var.region
  size = 10
  description = "Volume for db, logs, etc."
  initial_filesystem_type = "ext4"
}

resource "digitalocean_volume_attachment" "satelit_import" {
  droplet_id = digitalocean_droplet.satelit_import.id
  volume_id = digitalocean_volume.satelit_import.id
}

resource "digitalocean_firewall" "satelit_import" {
  name = "only-22-and-443-80"
  droplet_ids = [digitalocean_droplet.satelit_import.id]

  inbound_rule {
    protocol = "tcp"
    port_range = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol = "tcp"
    port_range = "80"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol = "tcp"
    port_range = "443"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
