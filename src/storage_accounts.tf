module "storage_accounts" {
  source   = "./modules/storage_account"
  for_each = var.storage_accounts

  settings        = each.value
  global_settings = var.global_settings

  resources = {
    resource_groups   = module.resource_groups
    virtual_networks  = module.virtual_networks
    private_dns_zones = module.private_dns_zones
  }
}
