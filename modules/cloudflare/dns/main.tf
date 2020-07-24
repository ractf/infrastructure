resource "cloudflare_zone" "ractf-root-domain" {
  zone = var.domain
}

resource "cloudflare_record" "homepage" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = "@"
  value   = var.homepage_endpoint
  type    = "CNAME"
  ttl     = 1
  proxied = false
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

resource "cloudflare_record" "elite-api" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = "elite-api"
  value   = var.elite_backend_endpoint
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "staging" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = "staging"
  value   = var.staging_endpoint
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "status" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = "status"
  value   = var.status_endpoint
  type    = "CNAME"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "ses_dkim" {
  count   = 3
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = "${element(var.ses_dkim_records, count.index)}._domainkey"
  value   = "${element(var.ses_dkim_records, count.index)}.dkim.amazonses.com"
  type    = "CNAME"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "mail" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = var.domain
  value   = var.mail_endpoint
  type    = "MX"
}

resource "cloudflare_record" "github" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = "_github-challenge"
  value   = var.github_token
  type    = "TXT"
}

resource "cloudflare_record" "github_secondary" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = "_github-challenge-ractf"
  value   = var.github_token
  type    = "TXT"
}

resource "cloudflare_record" "spf" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = var.domain
  value   = "v=spf1 a mx a:${var.mail_endpoint} include:amazonses.com -all"
  type    = "TXT"
}

resource "cloudflare_record" "google-verify" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = var.domain
  value   = var.google_token
  type    = "TXT"
}

resource "cloudflare_record" "production-h1" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = var.domain
  value   = var.h1_token_production
  type    = "TXT"
}

resource "cloudflare_record" "staging-h1" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = "staging"
  value   = var.h1_token_staging
  type    = "TXT"
}

resource "cloudflare_record" "ses-verify" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = var.domain
  value   = var.ses_token
  type    = "TXT"
}

resource "cloudflare_record" "dkim" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = "dkim._domainkey"
  value   = var.dkim_key
  type    = "TXT"
}
