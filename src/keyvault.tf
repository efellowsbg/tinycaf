module "keyvaults" {
  source   = "./modules/_security/keyvault"
  for_each = var.keyvaults

  settings        = each.value
  global_settings = var.global_settings
  client_config      = local.client_config
  tenant_id       = var.tenant_id
  resources = {
    resource_groups  = module.resource_groups
    virtual_networks = module.virtual_networks
    managed_identities = module.managed_identities
  }
}