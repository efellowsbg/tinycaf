module "private_dns_a_records" {
  source   = "./modules/private_dns_a_record"
  for_each = var.private_endpoints

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    resource_groups   = module.resource_groups
    virtual_networks  = module.virtual_networks
    private_dns_zones = module.private_dns_zones
  }
}
