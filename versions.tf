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
      source  = "cloudflare/cloudflare"
      version = "2.9.0"
    }
    consul = {
      source = "hashicorp/consul"
      version = "2.10.1"
    }
    nomad = {
      source = "hashicorp/nomad"
      version = "1.4.11"
    }
    local = {
      source = "hashicorp/local"
      version = "2.0.0"
    }
  }
}
