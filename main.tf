module "frontend" {
  source          = "./modules/aws/frontend"
  deployment_name = var.ractf_frontend_domain
  certificate     = module.certificate.arn
  deploy_account  = var.deploy_account
}

module "certificate" {
  source = "./modules/aws/certificate"
  domain = var.ractf_frontend_domain
  providers = {
    aws = aws.cert
  }
}

module "static" {
  source      = "./modules/aws/static"
  bucket_name = "files.${var.ractf_domain}"
}

module "ses" {
  source = "./modules/aws/ses"
  domain = var.ractf_domain
}

module "dns" {
  source              = "./modules/cloudflare/dns"
  domain              = var.ractf_domain
  backend_endpoint    = var.ractf_host
  mail_endpoint       = var.mail_host
  files_endpoint      = module.static.bucket_endpoint
  frontend_endpoint   = module.frontend.endpoint
  github_token        = var.github_token
  google_token        = var.google_token
  staging_endpoint    = var.staging_endpoint
  status_endpoint     = var.status_endpoint
  h1_token_production = var.h1_token_production
  h1_token_staging    = var.h1_token_staging
  ses_token           = module.ses.domain_token
  ses_dkim_records    = module.ses.dkim_records
  dkim_key            = var.dkim_key
}

module "shortener_dns" {
  source   = "./modules/cloudflare/shortener"
  domain   = var.ractf_shortener_domain
  endpoint = var.shortener_endpoint
}

module "dns_settings" {
  source = "./modules/cloudflare/settings"
  zone   = module.dns.zone
  domain = var.ractf_domain
}

module "shortener_settings" {
  source    = "./modules/cloudflare/settings"
  zone      = module.shortener_dns.zone
  domain    = var.ractf_shortener_domain
  shortener = true
}
