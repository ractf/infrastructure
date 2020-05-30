resource "cloudflare_record" "homepage" {
  zone_id = "${vars.RACTF_ZONE_ID}"
  name    = "@"
  value   = "${vars.RACTF_HOST}"
  type    = "A"
  ttl     = 3600
}
