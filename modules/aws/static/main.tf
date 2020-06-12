resource "aws_s3_bucket" "static_files" {
  bucket = var.bucket_name
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}
