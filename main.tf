module "vault" {
  source      = "./modules/support/vault"
  bucket_name = var.vault_bucket
}
