provider "aws" {
  version = "~> 2.0"
  region  = "eu-west-2"
}

provider "aws" {
  version = "~> 2.0"
  alias   = "cert"
  region  = "us-east-1"
}

provider "cloudflare" {
  version = "~> 2.0"
  email   = var.CLOUDFLARE_EMAIL
  api_key = var.CLOUDFLARE_API_KEY
}
