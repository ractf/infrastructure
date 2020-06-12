output "shell_deploy_id" {
  value       = aws_iam_access_key.shell_deploy_key.id
  description = "The ID of the AWS deploy key for shell"
}

output "shell_deploy_key" {
  value       = aws_iam_access_key.shell_deploy_key.secret
  description = "The key for the AWS deploy key for shell"
}
