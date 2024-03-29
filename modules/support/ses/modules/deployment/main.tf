resource "aws_ses_domain_identity" "email" {
  domain = var.domain
}

resource "aws_ses_domain_dkim" "email" {
  domain = aws_ses_domain_identity.email.domain
}

data "aws_iam_policy_document" "email_backend" {
  statement {
    actions   = ["SES:SendEmail", "SES:SendRawEmail"]
    resources = [aws_ses_domain_identity.email.arn]

    principals {
      identifiers = [var.user]
      type        = "AWS"
    }
    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values = [
        var.backend_endpoint
      ]
    }
  }
}

resource "aws_ses_identity_policy" "email_backend" {
  identity = aws_ses_domain_identity.email.arn
  name     = "email_backend_mail"
  policy   = data.aws_iam_policy_document.email_backend.json
}

resource "cloudflare_record" "ses_dkim" {
  zone_id = var.zone_id
  count   = 3
  name    = "${element(aws_ses_domain_dkim.email.dkim_tokens, count.index)}._domainkey"
  value   = "${element(aws_ses_domain_dkim.email.dkim_tokens, count.index)}.dkim.amazonses.com"
  type    = "CNAME"
  ttl     = 1
  proxied = false
}

resource "cloudflare_record" "ses_verify" {
  zone_id = var.zone_id
  name    = var.domain
  value   = aws_ses_domain_identity.email.verification_token
  type    = "TXT"
}
