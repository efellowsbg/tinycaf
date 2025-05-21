module "container_registries" {
  source   = "./modules/container_registry"
  for_each = var.container_registries

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    resource_groups   = module.resource_groups
    virtual_networks  = module.virtual_networks
    private_dns_zones = module.private_dns_zones
    key_vault_keys = module.key_vault_keys
  }
}
