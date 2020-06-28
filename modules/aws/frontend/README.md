# Frontend

Deploy an instance of the RACTF frontend.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| certificate | The ARN of the certificate to use when deploying the frontend | `string` | n/a | yes |
| deploy\_account | The ARN of the S3 deploy account | `string` | n/a | yes |
| deployment\_name | The domain name to use when deploying the frontend | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| endpoint | n/a |
