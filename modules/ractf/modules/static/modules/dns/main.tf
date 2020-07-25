resource "cloudflare_record" "files" {
  zone_id = var.zone
  name    = var.deployment_name
  value   = var.bucket_endpoint
  type    = "CNAME"
  ttl     = 1
  proxied = true
}
