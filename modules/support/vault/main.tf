data "aws_iam_policy_document" "vault_distribution" {
  statement {
    actions = ["s3:ListBucket"]
    principals {
      type        = "AWS"
      identifiers = [aws_iam_user.vault.arn]
    }
    resources = [aws_s3_bucket.vault_bucket.arn]
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:DeleteObject"
    ]
    principals {
      type        = "AWS"
      identifiers = [aws_iam_user.vault.arn]
    }
    resources = ["${aws_s3_bucket.vault_bucket.arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "vault_distribution" {
  bucket = aws_s3_bucket.vault_bucket.id
  policy = data.aws_iam_policy_document.vault_distribution.json
}

resource "aws_s3_bucket" "vault_bucket" {
  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Deployment = "Support"
  }
}

resource "aws_iam_user" "vault" {
  name = "vault"
  path = "/system/"
}

