module "postgres" {
  source   = "./modules/postgres"
  for_each = var.postgres

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    resource_groups    = module.resource_groups
    managed_identities = module.managed_identities
    keyvaults        = module.keyvaults
  }
}
