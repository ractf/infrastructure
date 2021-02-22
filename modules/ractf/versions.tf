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
    }
  }
  required_version = ">= 0.14"
}
