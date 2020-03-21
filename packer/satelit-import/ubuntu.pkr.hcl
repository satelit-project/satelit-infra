variable "do_token" { type = string }
variable "do_region" { default = "nyc1" }
variable "username" { default = "satelit" }
variable "userpass" { type = string }

source "digitalocean" "ubuntu" {
  api_token = var.do_token
  image = "ubuntu-19-10-x64"
  region = var.do_region
  size = "s-1vcpu-1gb"
  snapshot_name = "satelit-import"
  ssh_username = "root"
}

source "vagrant" "ubuntu" {
  source_path = "ubuntu/bionic64"
  provider = "virtualbox"
  box_name = "satelit-import"
  output_dir = "build-ubuntu"
  communicator = "ssh"
  add_force = true
}

build {
  sources = [
    "source.digitalocean.ubuntu",
    "source.vagrant.ubuntu"
  ]

  provisioner "shell" {
    script = "provision/docker.sh"
  }

  provisioner "shell" {
    script = "provision/users.sh"
    environment_vars = [
      "USER_NAME=${var.username}",
      "USER_PASSWD=${var.userpass}"
    ]
  }
}
