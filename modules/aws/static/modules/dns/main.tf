resource "cloudflare_zone" "root-domain" {
  zone = var.root_domain
}

resource "cloudflare_record" "files" {
  zone_id = cloudflare_zone.root-domain.id
  name    = var.deployment_name
  value   = var.files_endpoint
  type    = "CNAME"
  ttl     = 1
  proxied = true
}
