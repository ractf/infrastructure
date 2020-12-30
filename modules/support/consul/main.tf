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
    TLS = {
      Enabled = false
    }

    Listeners  = [{
      Port     = 80
      Protocol = "tcp"
      Services = [{
        Name = "nginx"
      }]
    }]
  })
}

resource "consul_intention" "production_gateway" {
  source_name      = "production-gateway"
  destination_name = "nginx"
  action           = "allow"
}

resource "consul_acl_policy" "production_gateway" {
  name  = "production-gateway"
  rules = <<-RULE
    service "production-gateway" {
      policy = "write"
    }

    service_prefix "" {
      policy = "read"
    }

    node_prefix "" {
      policy = "read"
    }

    agent_prefix "ix2gateway" {
      policy = "write"
    }
    RULE
}

resource "consul_acl_token" "production_gateway" {
  description = "Consul Connect gateway"
  policies = [consul_acl_policy.production_gateway.name]
}

resource "consul_config_entry" "testing_gateway" {
  kind = "ingress-gateway"
  name = "testing-gateway"
  config_json = jsonencode({
    TLS = {
      Enabled = false
    }

    Listeners  = [{
      Port     = 80
      Protocol = "tcp"
      Services = [{
        Name = "nginx"
      }]
    }]
  })
}

resource "consul_intention" "testing_gateway" {
  source_name      = "testing-gateway"
  destination_name = "nginx"
  action           = "allow"
}

resource "consul_acl_policy" "testing_gateway" {
  name  = "testing-gateway"
  rules = <<-RULE
    service "testing-gateway" {
      policy = "write"
    }

    service_prefix "" {
      policy = "read"
    }

    node_prefix "" {
      policy = "read"
    }

    agent_prefix "ix2gateway" {
      policy = "write"
    }
    RULE
}

resource "consul_acl_token" "testing_gateway" {
  description = "Consul Connect gateway"
  policies = [consul_acl_policy.testing_gateway.name]
}
