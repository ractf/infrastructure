resource "cloudflare_zone_settings_override" "settings" {
  zone_id = var.zone
  settings {
    ssl                      = var.shortener ? "flexible" : "full"
    always_use_https         = "on"
    opportunistic_encryption = "on"
    automatic_https_rewrites = "on"
    brotli                   = "on"
    http2                    = "on"
    http3                    = "on"
    zero_rtt                 = "on"
    websockets               = "on"
    opportunistic_onion      = "on"
    rocket_loader            = "on"
    min_tls_version	     = "1.2"
    tls_1_3		     = "zrt"
    minify {
      css  = "on"
      js   = "on"
      html = "on"
    }
  }
}

resource "cloudflare_page_rule" "files_ssl" {
  zone_id  = var.zone
  target   = "files-*.${var.domain}/*"
  priority = 1

  actions {
    ssl = "flexible"
  }
  count = var.shortener ? 0 : 1
}

resource "cloudflare_page_rule" "redirect_www" {
  zone_id  = var.zone
  target   = "${var.domain}/*"
  priority = 2

  actions {
    forwarding_url {
      url         = "https://www.${var.domain}"
      status_code = "302"
    }
  }
}
