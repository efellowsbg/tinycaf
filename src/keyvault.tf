module "keyvaults" {
  source   = "./modules/keyvault"
  for_each = var.keyvaults

  settings        = each.value
  global_settings = local.global_settings
  resources = {
    resource_groups    = module.resource_groups
    virtual_networks   = module.virtual_networks
    managed_identities = module.managed_identities
    private_dns_zones  = module.private_dns_zones
  }
}
