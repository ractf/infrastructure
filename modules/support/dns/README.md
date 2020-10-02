# Main DNS

Deploy the DNS records for RACTF.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| cloudflare | 2.9.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| dkim\_key | DKIM token from mail server | `string` | `""` | no |
| domain | The domain RACTF is being deployed on | `string` | n/a | yes |
| github\_token | The verification token for GitHub | `string` | `""` | no |
| google\_token | The verification token for Google | `string` | `""` | no |
| h1\_token\_production | HackerOne verification token for Production | `string` | `""` | no |
| h1\_token\_staging | HackerOne verification token for Staging | `string` | `""` | no |
| mail\_endpoint | The IP of the host the RACTF mail service is running on | `string` | `""` | no |
| staging\_endpoint | The IP of the staging server | `string` | `""` | no |
| status\_endpoint | The DNS name of the statuspage | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| zone | n/a |
