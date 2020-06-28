resource "aws_ses_domain_identity" "ractf" {
  domain = var.domain
}

resource "aws_ses_domain_dkim" "ractf" {
  domain = aws_ses_domain_identity.ractf.domain
}

data "aws_iam_policy_document" "ractf_backend" {
  statement {
    actions   = ["SES:SendEmail", "SES:SendRawEmail"]
    resources = [aws_ses_domain_identity.ractf.arn]

    principals {
      identifiers = [aws_iam_user.backend_ses.arn]
      type        = "AWS"
    }
  }
}

resource "aws_ses_identity_policy" "ractf_backend" {
  identity = aws_ses_domain_identity.ractf.arn
  name     = "ractf_backend_mail"
  policy   = data.aws_iam_policy_document.ractf_backend.json
}

data "aws_iam_user" "backend_ses" {
  user_name = "backend_ses_user"
}
