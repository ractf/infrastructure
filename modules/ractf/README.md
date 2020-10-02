# RACTF

Deploy an RACTF!

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| cloudflare | 2.9.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| backend\_endpoint | The IP address of the RACTF backend | `string` | n/a | yes |
| container\_registry | Should this deployment include a container registry? | `bool` | `false` | no |
| deploy\_account | The ARN of the S3 deploy account | `string` | n/a | yes |
| deployment\_name | The name of the RACTF deployment | `string` | n/a | yes |
| root\_domain | The root domain for the RACTF deployment | `string` | n/a | yes |
| zone | The Cloudflare Zone ID | `string` | n/a | yes |
