terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
    }
    newrelic = {
      source = "newrelic/newrelic"
    }
  }
  required_version = ">= 0.13"
}
