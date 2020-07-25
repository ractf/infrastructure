provider "aws" {
  version = "~> 2.0"
  region  = var.aws_region
}

provider "aws" {
  version = "~> 2.0"
  alias   = "cert"
  region  = "us-east-1"
}

provider "cloudflare" {
  version = "~> 2.0"
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}
