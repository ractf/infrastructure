module "deployment" {
  source   = "./modules/deployment"
  for_each = var.domains
  domain   = each.key
  zone_id  = each.value
  user     = aws_iam_user.backend_ses.arn
}

resource "aws_iam_user" "backend_ses" {
  name = "backend_ses_user"
  path = "/system/"
}
