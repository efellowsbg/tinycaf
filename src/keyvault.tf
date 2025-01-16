module "keyvaults" {
  source   = "./modules/_security/keyvault"
  for_each = var.keyvaults

  settings        = each.value
  global_settings = var.global_settings
  tenant_id       = var.tenant_id
  resources = {
    resource_groups  = module.resource_groups
    virtual_networks = module.virtual_networks
  }
}


module "keyvault_access_policies" {
  source   = "./_modules/_security/keyvault_access_policies"
  for_each = var.keyvault_access_policies

  keyvault_key    = each.key
  keyvaults       = local.combined_objects_keyvaults
  keyvault_id     = try(each.value.keyvault_id, null)
  access_policies = each.value
  azuread_groups  = local.combined_objects_azuread_groups
  client_config   = local.client_config
  resources = {
    managed_identities          = module.managed_identities
  }
}