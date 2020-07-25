# Main DNS

Deploy the DNS records for RACTF.

## Providers

| Name | Version |
|------|---------|
| cloudflare | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| backend\_endpoint | The IP of the host the RACTF backend is running on | `string` | n/a | yes |
| domain | The domain RACTF is being deployed on | `string` | n/a | yes |
| files\_endpoint | The domain of the S3 files bucket hosting challenges | `string` | n/a | yes |
| frontend\_endpoint | The domain of the Cloudfront distribution with the RACTF frontend | `string` | n/a | yes |
| github\_token | The verification token for GitHub | `string` | n/a | yes |
| google\_token | The verification token for Google | `string` | n/a | yes |
| h1\_token\_production | HackerOne verification token for Production | `string` | n/a | yes |
| h1\_token\_staging | HackerOne verification token for Staging | `string` | n/a | yes |
| mail\_endpoint | The IP of the host the RACTF mail service is running on | `string` | n/a | yes |
| staging\_endpoint | The IP of the staging server | `string` | n/a | yes |
| status\_endpoint | The DNS name of the statuspage | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| zone | n/a |
