provider "aws" {}

provider "aws" {
  alias = "useast1"
}

resource "aws_acm_certificate" "cert" {
  domain_name       = var.deployment_name
  validation_method = "DNS"
  provider = aws.useast1

  tags = {
    Environment = "production"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_cloudfront_origin_access_identity" "frontend_distribution" {
}

data "aws_iam_policy_document" "frontend_distribution" {
  statement {
    actions = ["s3:GetObject"]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.frontend_distribution.iam_arn]
    }
    resources = ["${aws_s3_bucket.frontend_bucket.arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "frontend_distribution" {
  bucket = aws_s3_bucket.frontend_bucket.id
  policy = data.aws_iam_policy_document.frontend_distribution.json
}

resource "aws_s3_bucket" "frontend_bucket" {
  bucket = var.deployment_name
  acl    = "private"

  tags = {
    Name = "RACTF Frontend"
  }
}

locals {
  s3_origin_id = "frontendS3Origin"
}

resource "aws_cloudfront_distribution" "frontend_distribution" {
  origin {
    domain_name = aws_s3_bucket.frontend_bucket.bucket_regional_domain_name
    origin_id   = local.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.frontend_distribution.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "RACTF Frontend"
  default_root_object = "index.html"

  aliases = [var.deployment_name]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Environment = "production"
  }

  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.cert.arn
  }

  custom_error_response {
    error_code         = "404"
    response_code      = "200"
    response_page_path = "/index.html"
  }
}

