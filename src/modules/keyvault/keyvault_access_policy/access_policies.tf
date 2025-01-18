resource "azurerm_key_vault_access_policy" "this" {
  for_each = {
    for key, value in var.resources.keyvaults :
    key => value.access_policies
    if contains(keys(value), "access_policies")
  }

  key_vault_id = var.resources.keyvaults[each.key].id
  tenant_id    = var.global_settings.tenant_id
  object_id    = var.object_id

  secret_permissions      = try(each.value.secret_permissions, [])
  key_permissions         = try(each.value.key_permissions, [])
  certificate_permissions = try(each.value.certificate_permissions, [])
  storage_permissions     = try(each.value.storage_permissions, [])
}
# resource "azurerm_key_vault_access_policy" "managed_identity" {
#   for_each = {
#     for access_policy_ref, config in var.settings.access_policies :
#     access_policy_ref => config
#     if can(config.managed_identity_ref)
#   }
#   key_vault_id = var.key_vault_id
#   tenant_id    = var.global_settings.tenant_id
#   object_id    = var.resources.managed_identities[each.value.managed_identity_ref].principal_id

#   # this is a bit of a hack to allow `secret_permissions` to be a string when "All" and otherwise a list
#   # the tfvars allows it, but the module needs us to convert it to list explicitly to get around the type errors
#   secret_permissions = try(each.value.secret_permissions, null) == "All" ? local.all_secret_permissions : try(tolist(each.value.secret_permissions), [])
#   key_permissions    = try(each.value.key_permissions, null) == "All" ? local.all_key_permissions : try(tolist(each.value.key_permissions), [])
# }
