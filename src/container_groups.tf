module "container_groups" {
  source   = "./modules/container_group"
  for_each = var.container_groups

  settings        = each.value
  global_settings = local.global_settings

  resources = {
    resource_groups          = module.resource_groups
    managed_identities       = module.managed_identities
    virtual_networks         = module.virtual_networks
    log_analytics_workspaces = module.log_analytics_workspaces
  }
}
