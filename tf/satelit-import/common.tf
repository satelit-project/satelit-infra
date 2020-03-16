terraform {
  backend "remote" {
    organization = "satelit"
    workspaces {
      name = "satelit-import"
    }
  }
}
