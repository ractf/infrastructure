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
                "tagStatus": "untagged",
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

resource "aws_iam_user" "push" {
  name = "push-${var.deployment_name}"
  path = "/registry/"
}

data "aws_iam_policy_document" "push" {
  statement {
    sid    = "PushToECR"
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:BatchDeleteImage"
    ]

    principals {
      type        = "AWS"
      identifiers = [aws_iam_user.push.arn]
    }
  }
}

resource "aws_ecr_repository_policy" "push" {
  repository = aws_ecr_repository.registry.name
  policy     = data.aws_iam_policy_document.push.json
}

resource "aws_iam_user" "pull" {
  name = "pull-${var.deployment_name}"
  path = "/registry/"
}

data "aws_iam_policy_document" "pull" {
  statement {
    sid    = "PullFromECR"
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
    ]

    principals {
      type        = "AWS"
      identifiers = [aws_iam_user.pull.arn]
    }
  }
}

resource "aws_ecr_repository_policy" "pull" {
  repository = aws_ecr_repository.registry.name
  policy     = data.aws_iam_policy_document.pull.json
}
