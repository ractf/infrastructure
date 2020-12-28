resource "consul_config_entry" "proxy_defaults" {
  kind = "proxy-defaults"
  name = "global"
  config_json = jsonencode({
    Config = {
      local_connect_timeout_ms = 1000
      handshake_timeout_ms     = 10000
    }
  })
}

resource "consul_config_entry" "production_gateway" {
  kind = "ingress-gateway"
  name = "production-gateway"
  config_json = jsonencode({
    Listeners = [{
      Port    = 80
      Protocl = "TCP"
      Services = [{
        Name = "traefik-api"
      }]
    }]
  })
}

resource "consul_intention" "production_gateway" {
  source_name      = "production-gateway"
  destination_name = "traefik-api"
  action           = "allow"
}
