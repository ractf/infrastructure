terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "2.9.0"
    }
    newrelic = {
      source  = "newrelic/newrelic"
      version = "2.14.0"
    }
  }
  required_version = ">= 0.13"
}
