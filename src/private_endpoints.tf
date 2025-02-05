module "private_endpoints" {
  source   = "./modules/private_endpoint"
  for_each = var.private_endpoints

  settings        = each.value
  global_settings = local.global_settings

  resource_type = each.value.private_service_connection.resource_type
  resource_ref  = each.value.private_service_connection.resource_ref

  resources = {
    resource_groups   = module.resource_groups
    virtual_networks  = module.virtual_networks
    private_dns_zones = module.private_dns_zones
    storage_accounts  = module.storage_accounts
  }
}
