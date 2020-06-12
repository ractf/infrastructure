resource "cloudflare_zone" "ractf-shortener-domain" {
    zone = vars.RACTF_SHORTENER_DOMAIN
}

resource "cloudflare_record" "shortener" {
  zone_id = cloudflare_zone.ractf-shortener-domain.id
  name    = "@"
  value   = vars.shortener_endpoint
  type    = "A"
  ttl     = 3600
  proxied = true
}
