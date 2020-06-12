output "bucket_endpoint" {
    value = aws_s3_bucket.frontend_bucket.website_endpoint
}