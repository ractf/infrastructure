output "origin_response_arn" {
  value = aws_lambda_function.origin_response_lambda.qualified_arn
}

output "viewer_request_arn" {
  value = aws_lambda_function.viewer_request_lambda.qualified_arn
}
