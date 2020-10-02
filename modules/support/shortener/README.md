# Shortener DNS

Deploy the DNS records for the RACTF link shortener.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| cloudflare | 2.9.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| domain | The domain RACTF is being deployed on | `string` | n/a | yes |
| endpoint | The IP of the host the RACTF shortener is running on | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| zone | n/a |
