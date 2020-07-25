module "homepage" {
  source          = "./modules/ractf/modules/frontend"
  deployment_name = "www"
  deploy_account  = var.deploy_account
  root_domain     = var.root_domain
  zone            = module.dns.zone
}

module "r2020" {
  source           = "./modules/ractf"
  deployment_name  = "2020"
  root_domain      = var.root_domain
  backend_endpoint = var.ractf_host
  deploy_account   = var.deploy_account
  zone             = module.dns.zone
}

module "elite" {
  source           = "./modules/ractf"
  deployment_name  = "elite"
  root_domain      = var.root_domain
  backend_endpoint = var.ractf_host
  deploy_account   = var.deploy_account
  zone             = module.dns.zone
}

module "ses" {
  source = "./modules/support/ses"
  domain = var.root_domain
}

module "dns" {
  source              = "./modules/support/dns"
  domain              = var.root_domain
  mail_endpoint       = var.mail_host
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
  source   = "./modules/support/shortener"
  domain   = var.ractf_shortener_domain
  endpoint = var.shortener_endpoint
}

module "dns_settings" {
  source = "./modules/support/settings"
  zone   = module.dns.zone
  domain = var.root_domain
}

module "shortener_settings" {
  source    = "./modules/support/settings"
  zone      = module.shortener_dns.zone
  domain    = var.ractf_shortener_domain
  shortener = true
}
