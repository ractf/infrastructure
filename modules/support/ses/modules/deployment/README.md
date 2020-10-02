# Deployment

Deploy the repeated components of SES

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| domain | The domain name to use when sending email | `string` | n/a | yes |
| user | The ARN of the IAM user to grant email permissions to | `string` | n/a | yes |
| zone\_id | The Zone ID to use when setting DNS | `string` | n/a | yes |
