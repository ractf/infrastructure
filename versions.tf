terraform {
  required_version = ">= 0.12"
  backend "remote" {
    organization = "ractf"

    workspaces {
      name = "infrastructure"
    }
  }
}
