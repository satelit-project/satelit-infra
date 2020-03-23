variable "do_token" { type = string }
variable "do_region" { default = "nyc1" }
variable "username" { default = "satelit" }
variable "userpass" { type = string }

source "digitalocean" "ubuntu" {
  api_token = var.do_token
  image = "ubuntu-18-04-x64"
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

  provisioner "shell-local" {
    script = "./gen-env.fish"
  }

  provisioner "file" {
    source = "provision/common.sh"
    destination = "/tmp/common.sh"
  }

  provisioner "shell" {
    scripts = [
      "provision/deps.sh",
      "provision/users.sh",
      "provision/volumes.sh",
      "provision/pre-files.sh"
    ]
    environment_vars = [
      "USER_NAME=${var.username}",
      "USER_PASSWD=${var.userpass}"
    ]
  }

  provisioner "file" {
    source = "resources/sshd_config"
    destination = "/etc/ssh/sshd_config"
  }

  provisioner "file" {
    source = "resources/authorized_keys"
    destination = "/home/${var.username}/.ssh/authorized_keys"
  }

  provisioner "file" {
    source = "resources/docker-compose.yml"
    destination = "/home/${var.username}/satelit-import/docker-compose.yml"
  }

  provisioner "file" {
    source = "resources/.env"
    destination = "/home/${var.username}/satelit-import/.env"
  }

  provisioner "shell" {
    script = "provision/post-files.sh"
    environment_vars = [
      "USER_NAME=${var.username}"
    ]
  }
}
