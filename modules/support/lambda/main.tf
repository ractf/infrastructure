locals {
  viewer_request_lambda  = "viewer_request_lambda"
  origin_response_lambda = "origin_response_lambda"
}

resource "aws_iam_role" "lambda_role" {
  assume_role_policy = aws_iam_policy_document.lambda_role.json
}

data "aws_iam_policy_document" "lambda_role" {
  statement {
    sid = "cloudfront_role"

    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com", "edgelambda.amazonaws.com"]
    }
  }
}

resource "aws_cloudwatch_log_group" "terraform_lambda_edge_python_log_group" {
  name              = "/aws/lambda/eu-west-2.terraform_lambda_edge_python"
  retention_in_days = 2
}

resource "aws_iam_policy" "lambda_logging" {
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = aws_iam_policy_document.lambda_logging.json
}

data "aws_iam_policy_document" "lambda_logging" {
  statement {
    sid       = "lambda_logging"
    actions   = ["logs:CreateLogGroup", "logs:Cre3ateLogStream", "logs:PutLogEvents"]
    resources = ["arn:aws:logs:*:*:*"] # TODO
  }
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

data "archive_file" "origin_response_lambda" {
  type        = "zip"
  source_file = "./scripts/originresponse.js"
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
  source_file = "./scripts/viewerrequest.js"
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
