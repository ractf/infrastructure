resource "cloudflare_record" "frontend" {
  zone_id = var.zone
  name    = var.deployment_name
  value   = var.endpoint
  type    = "CNAME"
  proxied = false
}
