resource "cloudflare_zone" "domain" {
  zone = var.domain
}

resource "cloudflare_zone_settings_override" "settings" {
    zone_id = cloudflare_zone.domain.id
    settings {
        ssl = var.shortener ? "flexible" : "full"
        always_use_https = "on"
        opportunistic_encryption = "on"
        automatic_https_rewrites = "on"
        tls_1_3 = "on"
        brotli = "on"
        http2 = "on"
        http3 = "on"
        zero_rtt = "on"
        websockets = "on"
        opportunistic_onion = "on"
    }
}

resource "cloudflare_page_rule" "files_ssl" {
  zone_id = cloudflare_zone.domain.id
  target = "files.${var.domain}/*"
  priority = 1

  actions {
    ssl = "flexible"
  }
  count = var.shortener ? 0 : 1
}
