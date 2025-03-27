module "role_assignments" {
  source = "./modules/role_assignments"

  settings        = var.role_assignments
  global_settings = local.global_settings

  resources = {
    resource_groups     = module.resource_groups
    keyvaults           = module.keyvaults
    managed_identities  = module.managed_identities
    kubernetes_clusters = module.kubernetes_clusters
    virtual_networks    = module.virtual_networks
    storage_accounts    = module.storage_accounts
    role_definitions    = module.role_definitions
    disk_encryption_sets = module.disk_encryption_sets
  }
}
