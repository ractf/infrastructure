resource "aws_s3_bucket" "static_files" {
  bucket = var.bucket_name

  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}

resource "aws_s3_bucket_policy" "static_files_cloudflare" {
  bucket = "${aws_s3_bucket.static_files.id}"

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "files-cloudflare-only",
  "Statement": [
    {
      "Sid": "CloudFlareAllow",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "${aws_s3_bucket.static_files.arn}/*",
      "Condition": {
         "IpAddress": {"aws:SourceIp": ${data.cloudflare_ip_ranges.cloudflare.cidr_blocks}}
      }
    }
  ]
}
POLICY
}

resource "aws_s3_bucket_object" "static_homepage" {
  bucket       = aws_s3_bucket.static_files.id
  key          = "index.html"
  source       = "${path.module}/index.html"
  etag         = filemd5("${path.module}/index.html")
  content_type = "text/html"
}
