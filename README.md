# Infrastructure

The infrastructure-as-code which runs the cloud components of RACTF.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | ~> 3.2 |
| cloudflare | ~> 2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cloudflare\_api\_key | n/a | `string` | n/a | yes |
| cloudflare\_email | n/a | `string` | n/a | yes |
| deploy\_account | The ARN of the S3 deploy account | `string` | n/a | yes |
| github\_token | GitHub verification token | `string` | n/a | yes |
| google\_token | Google verification token | `string` | n/a | yes |
| h1\_token\_production | HackerOne verification token for Production | `string` | n/a | yes |
| h1\_token\_staging | HackerOne verification token for Staging | `string` | n/a | yes |
| mail\_host | The IP of the host the RACTF email services are running on | `string` | n/a | yes |
| ractf\_domain | n/a | `string` | n/a | yes |
| ractf\_frontend\_domain | n/a | `string` | n/a | yes |
| ractf\_host | The IP of the host the RACTF backend is running on | `string` | n/a | yes |
| ractf\_shortener\_domain | n/a | `string` | n/a | yes |
| shortener\_endpoint | The IP of the host the RACTF shortener is running on | `string` | n/a | yes |
| staging\_endpoint | The IP of the staging server | `string` | n/a | yes |
| status\_endpoint | The DNS name of the statuspage | `string` | n/a | yes |
