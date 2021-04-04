resource "cloudflare_zone" "ractf-root-domain" {
  zone = var.domain
}

resource "cloudflare_record" "home" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = "@"
  value   = "example.com"
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "consul" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  count   = var.consul_host != "" ? 1 : 0
  name    = "infra-consul"
  value   = var.consul_host
  type    = "CNAME"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "nomad" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  count   = var.consul_host != "" ? 1 : 0
  name    = "infra-nomad"
  value   = var.consul_host
  type    = "CNAME"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "keycloak" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  count   = var.consul_host != "" ? 1 : 0
  name    = "sso"
  value   = var.consul_host
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "blog" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  count   = var.consul_host != "" ? 1 : 0
  name    = "blog"
  value   = var.consul_host
  type    = "CNAME"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "staging" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  count   = var.staging_endpoint != "" ? 1 : 0
  name    = "staging"
  value   = var.staging_endpoint
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "mail_frontend" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  count   = var.mail_frontend != "" ? 1 : 0
  name    = "mail"
  value   = var.mail_frontend
  type    = "A"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "staging-ephemeral" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  count   = var.staging_endpoint != "" ? 1 : 0
  name    = "staging-ephemeral"
  value   = var.staging_endpoint
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "status" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  count   = var.status_endpoint != "" ? 1 : 0
  name    = "status"
  value   = var.status_endpoint
  type    = "CNAME"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "mail" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  count   = var.mail_endpoint != "" ? 1 : 0
  name    = var.domain
  value   = var.mail_endpoint
  type    = "MX"
}

resource "cloudflare_record" "github" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  count   = var.github_token != "" ? 1 : 0
  name    = "_github-challenge"
  value   = var.github_token
  type    = "TXT"
}

resource "cloudflare_record" "github_secondary" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  count   = var.github_token != "" ? 1 : 0
  name    = "_github-challenge-ractf"
  value   = var.github_token
  type    = "TXT"
}

resource "cloudflare_record" "spf" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  count   = var.mail_endpoint != "" ? 1 : 0
  name    = var.domain
  value   = "v=spf1 a mx a:${var.mail_endpoint} include:amazonses.com include:_spf.atlassian.net -all"
  type    = "TXT"
}

resource "cloudflare_record" "google-verify" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  count   = var.google_token != "" ? 1 : 0
  name    = var.domain
  value   = var.google_token
  type    = "TXT"
}

resource "cloudflare_record" "atlassian-verify" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  count   = var.atlassian_token != "" ? 1 : 0
  name    = var.domain
  value   = var.atlassian_token
  type    = "TXT"
}

resource "cloudflare_record" "production-h1" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  count   = var.h1_token_production != "" ? 1 : 0
  name    = var.domain
  value   = var.h1_token_production
  type    = "TXT"
}

resource "cloudflare_record" "staging-h1" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  count   = var.h1_token_staging != "" ? 1 : 0
  name    = "staging"
  value   = var.h1_token_staging
  type    = "TXT"
}

resource "cloudflare_record" "dkim" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  count   = var.dkim_key != "" ? 1 : 0
  name    = "dkim._domainkey"
  value   = var.dkim_key
  type    = "TXT"
}

resource "cloudflare_record" "dkim_atlassian1" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = "s1._domainkey"
  value   = "s1._domainkey.atlassian.net"
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "dkim_atlassian2" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = "s2._domainkey"
  value   = "s2._domainkey.atlassian.net"
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "dmarc" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  count   = var.dmarc_record != "" ? 1 : 0
  name    = "_dmarc"
  value   = var.dmarc_record
  type    = "TXT"
}
