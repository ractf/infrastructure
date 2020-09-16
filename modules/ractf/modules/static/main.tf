resource "aws_s3_bucket" "static_files" {
  bucket = "files-${var.deployment_name}.${var.root_domain}"

  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}

data "cloudflare_ip_ranges" "cloudflare" {}

resource "aws_s3_bucket_policy" "static_files_cloudflare" {
  bucket = aws_s3_bucket.static_files.id
  policy = data.aws_iam_policy_document.static_files_cloudflare.json
}

data "aws_iam_policy_document" "static_files_cloudflare" {
  policy_id = "static_files_cloudflare"
  statement {
    sid       = "CloudflareAllow"
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.static_files.arn}/*"]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values   = data.cloudflare_ip_ranges.cloudflare.cidr_blocks
    }
  }
}

resource "aws_s3_bucket_object" "static_homepage" {
  bucket       = aws_s3_bucket.static_files.id
  key          = "index.html"
  source       = "${path.module}/assets/index.html"
  etag         = filemd5("${path.module}/assets/index.html")
  content_type = "text/html"
  tags = {
    Deployment = var.deployment_name
  }
}

resource "aws_s3_bucket_object" "static_robots" {
  bucket       = aws_s3_bucket.static_files.id
  key          = "robots.txt"
  source       = "${path.module}/assets/robots.txt"
  etag         = filemd5("${path.module}/assets/robots.txt")
  content_type = "text/plain"
  tags = {
    Deployment = var.deployment_name
  }
}

resource "aws_s3_bucket_object" "static_favicon" {
  bucket       = aws_s3_bucket.static_files.id
  key          = "favicon.ico"
  source       = "${path.module}/assets/favicon.ico"
  etag         = filemd5("${path.module}/assets/favicon.ico")
  content_type = "image/vnd.microsoft.ico"
  tags = {
    Deployment = var.deployment_name
  }
}

module "dns" {
  source          = "./modules/dns"
  deployment_name = var.deployment_name
  bucket_endpoint = aws_s3_bucket.static_files.website_endpoint
  root_domain     = var.root_domain
  zone            = var.zone
}
