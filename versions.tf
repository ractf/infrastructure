terraform {
  required_version = ">= 0.13"
  backend "remote" {
    organization = "ractf"

    workspaces {
      name = "infrastructure"
    }
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    cloudflare = {
      source = "terraform-providers/cloudflare"
    }
  }
}
