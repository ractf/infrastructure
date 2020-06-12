variable "shell_repo" {
    type = string
    description = "The full name of the shell repo"
}

variable "shell_deploy_id" {
    type = string
    description = "The ID of the AWS deploy key for shell"
}

variable "shell_deploy_key" {
    type = string
    description = "The key for the AWS deploy key for shell"
}

variable "shell_bucket" {
    type = string
    description = "The S3 bucket for shell"
}
