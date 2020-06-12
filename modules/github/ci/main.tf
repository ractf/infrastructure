resource "github_actions_secret" "access_key_id" {
  repository      = var.shell_repo
  secret_name     = "AWS_ACCESS_KEY_ID"
  plaintext_value = var.shell_deploy_id
}

resource "github_actions_secret" "access_key" {
  repository      = var.shell_repo
  secret_name     = "AWS_SECRET_ACCESS_KEY"
  plaintext_value = var.shell_deploy_key
}

resource "github_actions_secret" "shell_bucket" {
  repository      = var.shell_repo
  secret_name     = "AWS_S3_BUCKET"
  plaintext_value = var.shell_bucket
}
