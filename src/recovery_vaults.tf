module "recovery_vaults" {
  source   = "./modules/recovery_vaults"
  for_each = var.recovery_vaults

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    resource_groups = module.resource_groups
    managed_identities = module.managed_identities
    key_vault_keys        = module.key_vault_keys
    virtual_networks = module.virtual_networks
  }
}
