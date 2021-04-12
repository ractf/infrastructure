resource "cloudflare_record" "root" {
  zone_id = var.zone
  name    = "@"
  value   = var.staging_endpoint
  type    = "A"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "wildcard" {
  zone_id = var.zone
  name    = "*"
  value   = var.staging_endpoint
  type    = "A"
  ttl     = 1
  proxied = false
}
