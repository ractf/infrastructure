# Shortener DNS

Deploy the DNS records for the RACTF link shortener.
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| cloudflare | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| domain | The domain RACTF is being deployed on | `string` | n/a | yes |
| endpoint | The IP of the host the RACTF shortener is running on | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| zone | n/a |
