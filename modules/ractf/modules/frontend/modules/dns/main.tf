resource "cloudflare_zone" "ractf-root-domain" {
  zone = var.root_domain
}

resource "cloudflare_record" "frontend" {
  zone_id = cloudflare_zone.ractf-root-domain.id
  name    = var.deployment_name
  value   = var.endpoint
  type    = "CNAME"
  proxied = false
}
