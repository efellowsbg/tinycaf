module "key_vault_keys" {
  source   = "./modules/keyvault/key_vault_key"
  for_each = var.key_vault_keys

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    resource_groups  = module.resource_groups
    keyvaults        = module.keyvaults
    virtual_networks = module.virtual_networks
    role_assignments = module.role_assignments
  }
}
