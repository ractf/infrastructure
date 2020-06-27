resource "cloudflare_zone" "ractf-root-domain" {
  zone = var.domain
}

resource "cloudflare_record" "homepage" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = "@"
  value   = var.backend_endpoint
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "www" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = "www"
  value   = var.backend_endpoint
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "api" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = "api"
  value   = var.backend_endpoint
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "staging" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = "api"
  value   = var.staging_endpoint
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "files" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = "files"
  value   = var.files_endpoint
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "frontend" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = "2020"
  value   = var.frontend_endpoint
  type    = "CNAME"
  ttl     = 3600
  proxied = false
}

resource "cloudflare_record" "status" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = "status"
  value   = var.status_endpoint
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "mail" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = var.domain
  value   = var.mail_endpoint
  type    = "MX"
  ttl     = 3600
}

resource "cloudflare_record" "github" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = "_github-challenge"
  value   = var.github_token
  type    = "TXT"
  ttl     = 3600
}

resource "cloudflare_record" "github_secondary" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = "_github-challenge-ractf"
  value   = var.github_token
  type    = "TXT"
  ttl     = 3600
}

resource "cloudflare_record" "spf" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = var.domain
  value   = "v=spf1 a mx ip4:${var.mail_endpoint} -all"
  type    = "TXT"
  ttl     = 3600
}

resource "cloudflare_record" "google-verify" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = var.domain
  value   = var.google_token
  type    = "TXT"
  ttl     = 3600
}

resource "cloudflare_record" "production-h1" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = var.domain
  value   = var.h1_token_production
  type    = "TXT"
  ttl     = 3600
}

resource "cloudflare_record" "staging-h1" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = "staging"
  value   = var.h1_token_staging
  type    = "TXT"
  ttl     = 3600
}
