module "role_assignments" {
  source   = "./modules/role_assignments"
  for_each = var.role_assignments

  settings        = each.key
  global_settings = local.global_settings

  resources = {
    resource_groups     = module.resource_groups
    keyvaults           = module.keyvaults
    managed_identities  = module.managed_identities
    kubernetes_clusters = module.kubernetes_clusters
    virtual_networks    = module.virtual_networks
    storage_accounts    = module.storage_accounts
    role_definitions    = module.role_definitions
  }
}
