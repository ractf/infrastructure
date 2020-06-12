output "endpoint" {
  value = aws_cloudfront_distribution.frontend_distribution.domain_name
}

output "s3_bucket" {
  value       = aws_s3_bucket.frontend_bucket.id
  description = "The S3 bucket containing frontend"
}

output "shell_deploy_id" {
  value       = module.deploy_user.shell_deploy_id
  description = "The ID of the AWS deploy key for shell"
}

output "shell_deploy_key" {
  value       = module.deploy_user.shell_deploy_key
  description = "The key for the AWS deploy key for shell"
}
