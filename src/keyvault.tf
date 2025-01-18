module "keyvaults" {
  source   = "./modules/keyvault"
  for_each = var.keyvaults

  settings        = each.value
  global_settings = local.global_settings
  resources = {
    virtual_networks   = module.virtual_networks
    resource_groups    = module.resource_groups
    managed_identities = module.managed_identities
    private_dns_zones  = module.private_dns_zones
  }
}

module "keyvault_access_policies" {
  source   = "./modules/keyvault_access_policy"

  for_each = {
    for key, kv in var.keyvaults : key => kv.access_policies
    if length(kv.access_policies) > 0
  }

  keyvault_id = module.keyvaults[each.key].id
  access_policy = each.value
  tenant_id     = var.global_settings.tenant_id

  # ✅ Conditionally set the object_id
  object_id = contains(keys(each.value), "logged_in_user") ? var.global_settings.object_id : var.resources.managed_identities[each.value.managed_identity_ref].principal_id

  global_settings = var.global_settings
}
