module "deployment" {
  source = "./modules/deployment"
  for_each = var.domains
  domain = each.value
  zone_id = var.zones[each.index]
  user = aws_iam_user.backend_ses.arn
}

resource "aws_iam_user" "backend_ses" {
  name = "backend_ses_user"
  path = "/system/"
}
