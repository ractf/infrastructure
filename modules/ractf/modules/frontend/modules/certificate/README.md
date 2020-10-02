# Certificate

Generate a certificate for use in Cloudfront

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | ~> 3.2 |
| cloudflare | 2.9.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| deployment\_name | The name of the RACTF deployment | `string` | n/a | yes |
| root\_domain | The root domain for the RACTF deployment | `string` | n/a | yes |
| zone | The Cloudflare Zone ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| arn | n/a |
