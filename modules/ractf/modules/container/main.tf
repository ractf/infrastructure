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
      "description": "Expire untagged images older than 1 day",
      "selection": {
        "tagStatus": "untagged",
        "countType": "sinceImagePushed",
        "countUnit": "days",
        "countNumber": 1
      },
      "action": {
        "type": "expire"
      }
    },
    {
      "rulePriority": 2,
      "description": "Expire images older than 14 days",
      "selection": {
        "tagStatus": "any",
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

data "aws_iam_policy_document" "policy" {
  statement {
    sid = "PushToECR"
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

  statement {
    sid = "PullFromECR"
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

resource "aws_ecr_repository_policy" "policy" {
  repository = aws_ecr_repository.registry.name
  policy     = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_user" "pull" {
  name = "pull-${var.deployment_name}"
  path = "/registry/"
}

data "aws_iam_policy_document" "login" {
  statement {
    sid = "LoginToECR"
    actions = [
      "ecr:GetAuthorizationToken"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "login" {
  name        = "${var.deployment_name}EcrLogin"
  path        = "/registry/"
  description = "Allow logging in to ECR"
  policy      = data.aws_iam_policy_document.login.json
}

resource "aws_iam_user_policy_attachment" "login-attach-push" {
  user       = aws_iam_user.push.name
  policy_arn = aws_iam_policy.login.arn
}

resource "aws_iam_user_policy_attachment" "login-attach-pull" {
  user       = aws_iam_user.pull.name
  policy_arn = aws_iam_policy.login.arn
}
