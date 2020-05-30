resource "cloudflare_record" "homepage" {
  zone_id = "${vars.RACTF_ZONE_ID}"
  name    = "@"
  value   = "${vars.RACTF_HOST}"
  type    = "A"
  ttl     = 3600
}

resource "cloudflare_record" "files" {
  zone_id = "${vars.RACTF_ZONE_ID}"
  name    = "files"
  value   = "${aws_s3_bucket.frontend_bucket.website_endpoint}"
  type    = "A"
  ttl     = 3600
}

