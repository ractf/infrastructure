terraform {
  required_version = ">= 0.14"
  backend "remote" {
    organization = "ractf"

    workspaces {
      name = "infrastructure"
    }
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.29.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "2.18.0"
    }
    consul = {
      source  = "hashicorp/consul"
      version = "2.11.0"
    }
    nomad = {
      source  = "hashicorp/nomad"
      version = "1.4.13"
    }
    newrelic = {
      source  = "newrelic/newrelic"
      version = "2.19.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "2.1.0"
    }
  }
}
