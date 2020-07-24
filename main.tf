module "homepage" {
  source          = "./modules/aws/frontend"
  deployment_name = "www"
  certificate     = module.homepage-certificate.arn
  deploy_account  = var.deploy_account
}

module "r2020" {
  source = "./modules/ractf"
  deployment_name = "2020"
  root_domain = var.ractf_domain
  backend_endpoint = var.ractf_host
}

module "elite" {
  source = "./modules/ractf"
  deployment_name = "elite"
  root_domain = var.ractf_domain
  backend_endpoint = var.ractf_host
}

module "ses" {
  source = "./modules/aws/ses"
  domain = var.ractf_domain
}

module "dns" {
  source                  = "./modules/support/dns"
  domain                  = var.ractf_domain
  mail_endpoint           = var.mail_host
  github_token            = var.github_token
  google_token            = var.google_token
  staging_endpoint        = var.staging_endpoint
  status_endpoint         = var.status_endpoint
  h1_token_production     = var.h1_token_production
  h1_token_staging        = var.h1_token_staging
  ses_token               = module.ses.domain_token
  ses_dkim_records        = module.ses.dkim_records
  dkim_key                = var.dkim_key
}

module "shortener_dns" {
  source   = "./modules/support/shortener"
  domain   = var.ractf_shortener_domain
  endpoint = var.shortener_endpoint
}

module "dns_settings" {
  source = "./modules/support/settings"
  zone   = module.dns.zone
  domain = var.ractf_domain
}

module "shortener_settings" {
  source    = "./modules/support/settings"
  zone      = module.shortener_dns.zone
  domain    = var.ractf_shortener_domain
  shortener = true
}
