terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "2.18.0"
    }
    newrelic = {
      source  = "newrelic/newrelic"
      version = "2.19.0"
    }
  }
  required_version = ">= 0.14"
}
