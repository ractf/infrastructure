resource "aws_s3_bucket" "static_files" {
  bucket = "files.ractf.co.uk"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "index.html"
  }
}