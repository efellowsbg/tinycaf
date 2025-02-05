module "private_endpoints" {
  source   = "./modules/private_endpoint"
  for_each = var.private_endpoints

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    resource_groups  = module.resource_groups
    virtual_networks = module.virtual_networks
  }
}
