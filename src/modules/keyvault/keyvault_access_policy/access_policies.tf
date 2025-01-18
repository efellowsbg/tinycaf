module "logged_in_user" {
  source = "./access_policy"
  keyvault_id = var.keyvault_id == null

  tenant_id     = var.global_settings.tenant_id
  object_id     = var.global_settings.object_id
  key_permissions = local.all_key_permissions
  secret_permissions = local.all_secret_permissions
}


module "managed_identities" {
  source = "./access_policy"
  for_each = (
    contains(keys(var.access_policies), "managed_identity_refs") && length(var.access_policies.managed_identity_refs) > 0
    ? var.access_policies.managed_identity_refs
    : {}
  )
  keyvault_id = var.keyvault_id == null

  tenant_id     = var.global_settings.tenant_id
  object_id     = var.resources.managed_identities[each.value].id
  key_permissions = try(var.access.key_permissions,null)
  secret_permissions = try(var.access.key_permissions,null)
}
