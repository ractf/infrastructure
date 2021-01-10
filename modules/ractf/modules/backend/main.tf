resource "cloudflare_record" "api" {
  zone_id = var.zone
  name    = "api-${var.deployment_name}"
  value   = var.backend_endpoint
  type    = "A"
  ttl     = 1
  proxied = false
}

resource "newrelic_synthetics_monitor" "stats" {
  name              = "${var.deployment_name} Stats"
  type              = "SIMPLE"
  frequency         = 1
  status            = "ENABLED"
  locations         = ["AWS_EU_WEST_2"]
  uri               = "https://api-${var.deployment_name}.${var.root_domain}/api/v2/stats/stats/"
  validation_string = "{\"s\":true,\"m\":\"\",\"d\":"
  verify_ssl        = true
  depends_on        = [cloudflare_record.api]
}

resource "newrelic_synthetics_alert_condition" "stats" {
  policy_id   = var.new_relic_policy_id
  name        = "${var.deployment_name} Alert Condition"
  monitor_id  = newrelic_synthetics_monitor.stats.id
}
