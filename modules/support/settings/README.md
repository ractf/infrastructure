# Settings

Set Cloudflare settings.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| cloudflare | 2.9.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| domain | The domain being edited | `string` | n/a | yes |
| shortener | Whether the domain is a shortener | `bool` | `false` | no |
| zone | The zone ID being edited | `string` | n/a | yes |
