resource "newrelic_alert_channel" "discord" {
  name = "Discord"
  type = "slack"

  config {
    url = var.discord_url
  }
}

resource "newrelic_alert_policy_channel" "channel" {
  policy_id  = newrelic_alert_policy.policy.id
  channel_ids = [
    newrelic_alert_channel.discord.id
  ]
}

resource "newrelic_alert_policy" "policy" {
  name = "policy"
}

resource "newrelic_infra_alert_condition" "host_not_reporting" {
  policy_id = newrelic_alert_policy.policy.id

  name       = "Host not reporting"
  type       = "infra_host_not_reporting"

  critical {
    duration = 5
  }
}
