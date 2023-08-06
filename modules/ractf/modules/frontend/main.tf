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

  statement {
    actions = ["s3:ListBucket"]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.frontend_distribution.iam_arn, var.deploy_account]
    }
    resources = [aws_s3_bucket.frontend_bucket.arn]
  }

  statement {
    actions = [
      "s3:GetObject",
      "s3:GetObjectAcl",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:DeleteObject"
    ]
    principals {
      type        = "AWS"
      identifiers = [var.deploy_account]
    }
    resources = ["${aws_s3_bucket.frontend_bucket.arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "frontend_distribution" {
  bucket = aws_s3_bucket.frontend_bucket.id
  policy = data.aws_iam_policy_document.frontend_distribution.json
}

resource "aws_s3_bucket" "frontend_bucket" {
  bucket = var.deployment_name != "*" ? "${var.deployment_name}.${var.root_domain}" : "wildcard.${var.root_domain}"
  acl    = "private"

  tags = {
    Deployment = var.deployment_name != "*" ? var.deployment_name : "wildcard"
  }
}

locals {
  s3_origin_id           = "frontendS3Origin"
  viewer_request_lambda  = "viewer_request_lambda"
  origin_response_lambda = "origin_response_lambda"
  react_array            = var.react ? [] : [0]
  header_array           = var.origin_response_arn == "" ? [] : [0]
  nice_deployment_name   = var.deployment_name != "*" ? var.deployment_name : "wildcard"
  nice_root_domain       = replace(var.root_domain, ".", "-")
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
  comment             = var.deployment_name
  default_root_object = "index.html"

  aliases = ["${var.deployment_name}.${var.root_domain}"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id
    cache_policy_id  = var.cache_policy

    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    dynamic "lambda_function_association" {
      for_each = local.header_array
      content {
        event_type   = "origin-response"
        lambda_arn   = var.origin_response_arn
        include_body = false
      }
    }

    dynamic "lambda_function_association" {
      for_each = local.react_array
      content {
        event_type   = "viewer-request"
        lambda_arn   = var.viewer_request_arn
        include_body = false
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Environment = "production"
    Deployment  = local.nice_deployment_name
  }

  viewer_certificate {
    acm_certificate_arn      = module.certificate.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }

  custom_error_response {
    error_caching_min_ttl = 0
    error_code            = "404"
    response_code         = var.react ? "200" : "404"
    response_page_path    = var.error_page
  }
}

resource "cloudflare_record" "frontend" {
  zone_id = var.zone
  name    = var.deployment_name
  value   = aws_cloudfront_distribution.frontend_distribution.domain_name
  type    = "CNAME"
  proxied = false
}

module "certificate" {
  source          = "./modules/certificate"
  root_domain     = var.root_domain
  deployment_name = var.deployment_name
  zone            = var.zone
  ractf_domains   = var.ractf_domains
  providers = {
    aws        = aws.cert
    cloudflare = cloudflare
  }
}
