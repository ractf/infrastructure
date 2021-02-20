provider "aws" {
  region  = var.aws_region
}

provider "aws" {
  alias   = "cert"
  region  = "us-east-1"
}

provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}

provider "consul" {
  address   = var.consul_address
  http_auth = var.consul_auth
  token     = var.consul_token
  cert_pem  = var.consul_cert
  key_pem   = var.consul_key
}

provider "nomad" {
  address   = var.nomad_address
  secret_id = var.nomad_token
}

provider "newrelic" {
  account_id = var.new_relic_id
  api_key    = var.new_relic_key
  region     = "EU"
}

provider "archive" {}
