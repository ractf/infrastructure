terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
    }
    newrelic = {
      source  = "newrelic/newrelic"
      version = "2.19.0"
    }
  }
  required_version = ">= 0.14"
}
