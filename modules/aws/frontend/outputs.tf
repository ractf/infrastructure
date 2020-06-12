output "endpoint" {
  value = aws_cloudfront_distribution.frontend_distribution.domain_name
}

output "s3_bucket" {
  type        = string
  value       = aws_s3_bucket.frontend_bucket.id
  description = "The S3 bucket containing frontend"
}

output "shell_deploy_id" {
  type        = string
  value       = aws_iam_access_key.shell_deploy_key.id
  description = "The ID of the AWS deploy key for shell"
}

output "shell_deploy_key" {
  type        = string
  value       = aws_iam_access_key.shell_deploy_key.secret
  description = "The key for the AWS deploy key for shell"
}
