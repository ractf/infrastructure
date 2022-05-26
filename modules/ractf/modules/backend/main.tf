resource "cloudflare_record" "api" {
  zone_id = var.zone
  name    = "api-${var.deployment_name}"
  value   = var.backend_endpoint
  type    = "A"
  ttl     = 1
  proxied = true
}
