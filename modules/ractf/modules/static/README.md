# Static

Deploy an S3 bucket to store challenge files.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| cloudflare | 2.9.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| deployment\_name | The domain name to use when deploying the frontend | `string` | n/a | yes |
| root\_domain | The root domain for the RACTF deployment | `string` | n/a | yes |
| zone | The Cloudflare Zone ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| bucket\_endpoint | n/a |
