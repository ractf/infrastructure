provider "aws" {
  version = "~> 2.0"
  region  = "eu-west-2"
}

provider "cloudflare" {
  version = "~> 2.0"
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}
