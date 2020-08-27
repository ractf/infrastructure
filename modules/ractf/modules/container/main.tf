resource "aws_ecr_repository" "registry" {
  name = var.deployment_name
  tags = {
    Deployment = var.deployment_name
  }
}


resource "aws_ecr_lifecycle_policy" "policy" {
  repository = aws_ecr_repository.registry.name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Expire images older than 14 days",
            "selection": {
                "countType": "sinceImagePushed",
                "countUnit": "days",
                "countNumber": 14
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}
