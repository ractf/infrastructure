resource "aws_iam_access_key" "shell_deploy_key" {
  user = aws_iam_user.shell_deploy.name
}

resource "aws_iam_user" "shell_deploy" {
  name = "shell_deploy"
  path = "/system/"
}

resource "aws_iam_user_policy" "lb_ro" {
  name = "test"
  user = aws_iam_user.shell_deploy.name

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
        {
            "Sid": "CI-Permissions-Read",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${aws_iam_user.shell_deploy.arn}"
            },
            "Action": "s3:ListBucket",
            "Resource": "${var.bucket_arn}"
        },
        {
            "Sid": "CI-Permissions",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${aws_iam_user.shell_deploy.arn}"
            },
            "Action": [
                "s3:PutObject",
                "s3:PutObjectAcl",
                "s3:GetObject",
                "s3:DeleteObject"
            ],
            "Resource": "${var.bucket_arn}/*"
        }
  ]
}
EOF
}
