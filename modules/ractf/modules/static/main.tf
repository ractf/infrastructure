resource "aws_s3_bucket" "files_bucket" {
  bucket = "files-${var.deployment_name}.${var.root_domain}"
  acl    = "private"

  tags = {
    Deployment = var.deployment_name != "*" ? var.deployment_name : "wildcard"
  }
}

locals {
  s3_origin_id     = "frontendS3Origin"
  nice_root_domain = replace(var.root_domain, ".", "-")
}

resource "aws_cloudfront_origin_access_identity" "files_distribution" {
}

data "aws_iam_policy_document" "files_distribution" {
  statement {
    actions = ["s3:GetObject"]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.files_distribution.iam_arn]
    }
    resources = ["${aws_s3_bucket.files_bucket.arn}/*"]
  }

  statement {
    actions = ["s3:ListBucket"]
    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.files_distribution.iam_arn]
    }
    resources = [aws_s3_bucket.files_bucket.arn]
  }

  statement {
    sid    = "BackendAllow"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:DeleteObject"
    ]
    resources = ["${aws_s3_bucket.files_bucket.arn}/challenge-files/*"]
    principals {
      type        = "AWS"
      identifiers = [var.backend_account]
    }
  }
}

resource "aws_s3_bucket_policy" "files_distribution" {
  bucket = aws_s3_bucket.files_bucket.id
  policy = data.aws_iam_policy_document.files_distribution.json
}

resource "aws_cloudfront_distribution" "files_distribution" {
  origin {
    domain_name = aws_s3_bucket.files_bucket.bucket_regional_domain_name
    origin_id   = local.s3_origin_id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.files_distribution.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "files-${var.deployment_name}"
  default_root_object = "index.html"

  aliases = ["files-${var.deployment_name}.${var.root_domain}"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id
    cache_policy_id  = var.cache_policy

    viewer_protocol_policy = "redirect-to-https"
    compress               = true

    lambda_function_association {
      event_type   = "origin-response"
      lambda_arn   = var.origin_response_arn
      include_body = false
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Environment = "production"
    Deployment  = var.deployment_name
  }

  viewer_certificate {
    acm_certificate_arn      = module.certificate.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2019"
  }

  custom_error_response {
    error_caching_min_ttl = 0
    error_code            = "404"
    response_code         = "404"
    response_page_path    = "/index.html"
  }
}


resource "aws_s3_bucket_object" "static_homepage" {
  bucket       = aws_s3_bucket.files_bucket.id
  key          = "index.html"
  source       = "${path.module}/assets/index.html"
  etag         = filemd5("${path.module}/assets/index.html")
  content_type = "text/html"
  tags = {
    Deployment = var.deployment_name
  }
}

resource "aws_s3_bucket_object" "static_robots" {
  bucket       = aws_s3_bucket.files_bucket.id
  key          = "robots.txt"
  source       = "${path.module}/assets/robots.txt"
  etag         = filemd5("${path.module}/assets/robots.txt")
  content_type = "text/plain"
  tags = {
    Deployment = var.deployment_name
  }
}

resource "aws_s3_bucket_object" "static_favicon" {
  bucket       = aws_s3_bucket.files_bucket.id
  key          = "favicon.ico"
  source       = "${path.module}/assets/favicon.ico"
  etag         = filemd5("${path.module}/assets/favicon.ico")
  content_type = "image/vnd.microsoft.ico"
  tags = {
    Deployment = var.deployment_name
  }
}

resource "cloudflare_record" "files" {
  zone_id = var.zone
  name    = "files-${var.deployment_name}"
  value   = aws_cloudfront_distribution.files_distribution.domain_name
  type    = "CNAME"
  proxied = false
}

module "certificate" {
  source          = "../frontend/modules/certificate"
  root_domain     = var.root_domain
  deployment_name = "files-${var.deployment_name}"
  zone            = var.zone
  ractf_domains   = var.ractf_domains
  providers = {
    aws        = aws.cert
    cloudflare = cloudflare
  }
}
