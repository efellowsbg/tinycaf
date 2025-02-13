module "container_groups" {
  source   = "./modules/container_group"
  for_each = var.container_groups

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    resource_groups          = module.resource_groups
    virtual_networks         = module.virtual_networks
    log_analytics_workspaces = module.log_analytics_workspaces
    managed_identities       = module.managed_identities
    key_vault_keys           = module.key_vault_keys
  }
}
