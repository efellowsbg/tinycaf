module "keyvaults" {
  source   = "./modules/_security/keyvault"
  for_each = var.keyvaults

  settings        = each.value
  global_settings = local.global_settings
  resources = {
    virtual_networks   = module.virtual_networks
    resource_groups    = module.resource_groups
    managed_identities = module.managed_identities
    private_dns_zones  = module.private_dns_zones
  }
}
