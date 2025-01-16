module "keyvaults" {
  source   = "./modules/_security/keyvault"
  for_each = var.keyvaults

  settings        = each.value
  global_settings = var.global_settings
  resources = {
    virtual_networks = module.virtual_networks
    public_ips       = module.public_ips
    resource_groups  = module.resource_groups
  }
}


module "keyvault_access_policies" {
  source   = "./modules/_security/keyvault_access_policies"
  for_each = var.keyvault_access_policies

  keyvault_key    = each.key
  keyvault_id     = try(each.value.keyvault_id, null)
  access_policies = each.value
  client_config   = local.client_config
  resources = {
    managed_identities          = module.managed_identities
  }
}