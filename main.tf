module "frontend" {
  source          = "./modules/aws/frontend"
  deployment_name = var.RACTF_DOMAIN
  certificate     = module.certificate.arn
}

module "certificate" {
  source = "./modules/aws/certificate"
  domain = var.RACTF_DOMAIN
  providers = {
    aws = aws.cert
  }
}

module "static" {
    source = "./modules/aws/static"
    bucket_name = "files.${var.RACTF_DOMAIN}"
}

module "frontend" {
    source = "./modules/aws/frontend"
    deployment_name = var.RACTF_DOMAIN
    certificate = module.certificate.arn
}

module "dns" {
  source            = "./modules/cloudflare/dns"
  domain            = var.RACTF_DOMAIN
  backend_endpoint  = var.ractf_host
  mail_endpoint     = var.mail_host
  files_endpoint    = modules.static.bucket_endpoint
  frontend_endpoint = "COME BACK"
  github_token      = var.github_token
  google_token      = var.google_token
}

module "shortener_dns" {
  source   = "./modules/cloudflare/shortener"
  domain   = var.RACTF_SHORTENER_DOMAIN
  endpoint = var.shortener_endpoint
}
