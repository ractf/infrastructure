locals {
  viewer_request_lambda  = "viewer_request_lambda"
  origin_response_lambda = "origin_response_lambda"
}

resource "aws_iam_role" "lambda_role" {
  assume_role_policy = data.aws_iam_policy_document.lambda_role.json
}

data "aws_iam_policy_document" "lambda_role" {
  statement {
    sid = "cloudfrontrole"

    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com", "edgelambda.amazonaws.com"]
    }
  }
}

resource "aws_cloudwatch_log_group" "viewer_request" {
  name              = "/aws/lambda/us-east-1.viewer_request_lambda"
  retention_in_days = 3
}

resource "aws_cloudwatch_log_group" "origin_response" {
  name              = "/aws/lambda/us-east-1.origin_response_lambda"
  retention_in_days = 3
}

resource "aws_iam_policy" "lambda_logging" {
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = data.aws_iam_policy_document.lambda_logging.json
}

data "aws_iam_policy_document" "lambda_logging" {
  statement {
    sid       = "lambdalogging"
    actions   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
    resources = ["arn:aws:logs:*:*:*"] # TODO
  }
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

data "archive_file" "origin_response_lambda" {
  type        = "zip"
  source_file = "${path.module}/scripts/origin_response.js"
  output_path = "origin_response_lambda.zip"
}

resource "aws_lambda_function" "origin_response_lambda" {
  depends_on    = [aws_iam_role_policy_attachment.lambda_logs]
  filename      = data.archive_file.origin_response_lambda.output_path
  function_name = local.origin_response_lambda
  role          = aws_iam_role.lambda_role.arn
  handler       = "origin_response.handler"

  source_code_hash = filebase64sha256(data.archive_file.origin_response_lambda.output_path)

  runtime = "nodejs12.x"

  publish = true
}

data "archive_file" "viewer_request_lambda" {
  type        = "zip"
  source_file = "${path.module}/scripts/viewer_request.js"
  output_path = "viewer_request_lambda.zip"
}

resource "aws_lambda_function" "viewer_request_lambda" {
  depends_on    = [aws_iam_role_policy_attachment.lambda_logs]
  filename      = data.archive_file.viewer_request_lambda.output_path
  function_name = local.viewer_request_lambda
  role          = aws_iam_role.lambda_role.arn
  handler       = "viewer_request.handler"

  source_code_hash = filebase64sha256(data.archive_file.viewer_request_lambda.output_path)

  runtime = "nodejs12.x"

  publish = true
}

resource "aws_cloudfront_cache_policy" "cache_policy" {
  name        = "${var.prefix}-cache-policy"
  comment     = "Policy for ractf"
  default_ttl = 86400
  max_ttl     = 604800
  min_ttl     = 1
  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }
    headers_config {
      header_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "none"
    }
    enable_accept_encoding_brotli = true
    enable_accept_encoding_gzip   = true
  }
}
