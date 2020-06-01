resource "cloudflare_zone" "ractf-root-domain" {
    zone = "${vars.RACTF_DOMAIN}"
}

resource "cloudflare_zone" "ractf-shortener-domain" {
    zone = "${vars.RACTF_SHORTENER_DOMAIN}"
}

resource "cloudflare_record" "homepage" {
  zone_id = "${cloudflare_zone.ractf-root-domain.id}"
  name    = "@"
  value   = "${vars.RACTF_HOST}"
  type    = "A"
  ttl     = 3600
  proxied = true
}

resource "cloudflare_record" "www" {
  zone_id = "${cloudflare_zone.ractf-root-domain.id}"
  name    = "www"
  value   = "${vars.RACTF_HOST}"
  type    = "A"
  ttl     = 3600
  proxied = true
}

resource "cloudflare_record" "api" {
  zone_id = "${cloudflare_zone.ractf-root-domain.id}"
  name    = "api"
  value   = "${vars.RACTF_HOST}"
  type    = "A"
  ttl     = 3600
  proxied = true
}

resource "cloudflare_record" "files" {
  zone_id = "${cloudflare_zone.ractf-root-domain.id}"
  name    = "files"
  value   = "${aws_s3_bucket.frontend_bucket.website_endpoint}"
  type    = "A"
  ttl     = 3600
  proxied = true
}

resource "cloudflare_record" "frontend" {
  zone_id = "${cloudflare_zone.ractf-root-domain.id}"
  name    = "2020"
  value   = "${aws_cloudfront_distribution.frontend_distribution.domain_name}"
  type    = "CNAME"
  ttl     = 3600
  proxied = false
}

resource "cloudflare_record" "mail" {
  zone_id = "${cloudflare_zone.ractf-root-domain.id}"
  value   = "${vars.RACTF_MAIL_HOST}"
  type    = "MX"
  ttl     = 3600
}

resource "cloudflare_record" "github" {
  zone_id = "${cloudflare_zone.ractf-root-domain.id}"
  name    = "_github-challenge"
  value   = "${vars.GITHUB_TOKEN}"
  type    = "TXT"
  ttl     = 3600
}


resource "cloudflare_record" "spf" {
  zone_id = "${cloudflare_zone.ractf-root-domain.id}"
  value   = "v=spf1 a mx ip4:${vars.RACTF_MAIL_HOST} -all"
  type    = "TXT"
  ttl     = 3600
}

resource "cloudflare_record" "google-verify" {
  zone_id = "${cloudflare_zone.ractf-root-domain.id}"
  value   = "${vars.GOOGLE_TOKEN}"
  type    = "TXT"
  ttl     = 3600
}


resource "cloudflare_record" "shortener" {
  zone_id = "${cloudflare_zone.ractf-shortener-domain.id}"
  name    = "@"
  value   = "${vars.RACTF_HOST}"
  type    = "A"
  ttl     = 3600
  proxied = true
}
