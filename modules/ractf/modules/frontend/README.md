# Frontend

Deploy an instance of the RACTF frontend.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| deploy\_account | The ARN of the S3 deploy account | `string` | n/a | yes |
| deployment\_name | The domain name to use when deploying the frontend | `string` | n/a | yes |
| root\_domain | The root domain for the RACTF deployment | `string` | n/a | yes |
| zone | The Cloudflare Zone ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| endpoint | n/a |
