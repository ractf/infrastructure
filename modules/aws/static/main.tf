resource "aws_s3_bucket" "static_files" {
  bucket = var.bucket_name
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}

resource "aws_s3_bucket_object" "static_homepage" {
  bucket = aws_s3_bucket.static_files.id
  key    = "index.html"
  source = "./index.html"
  etag   = filemd5("${path.module}/index.html")
}
