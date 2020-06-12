resource "cloudflare_zone" "ractf-shortener-domain" {
  zone = var.domain
}

resource "cloudflare_record" "shortener" {
  zone_id = cloudflare_zone.ractf-shortener-domain.id
  name    = "@"
  value   = vars.endpoint
  type    = "A"
  ttl     = 3600
  proxied = true
}
