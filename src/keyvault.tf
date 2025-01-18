module "keyvaults" {
  source   = "./modules/keyvault"
  for_each = var.keyvaults

  settings        = each.value
  global_settings = local.global_settings
  managed_identities = module.managed_identities
  resources = {
    virtual_networks   = module.virtual_networks
    resource_groups    = module.resource_groups
    managed_identities = module.managed_identities
    private_dns_zones  = module.private_dns_zones
    keyvaults = {
      for key, kv in azurerm_key_vault.main : key => kv
    }
  }
}
