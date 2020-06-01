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

resource "cloudflare_record" "api" {
  zone_id = "${cloudflare_zone.ractf-root-domain.id}"
  name    = "@"
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
  type    = "A"
  ttl     = 3600
  proxied = false
}

resource "cloudflare_record" "shortener" {
  zone_id = "${cloudflare_zone.ractf-shortener-domain.id}"
  name    = "@"
  value   = "${vars.RACTF_HOST}"
  type    = "A"
  ttl     = 3600
  proxied = true
}
