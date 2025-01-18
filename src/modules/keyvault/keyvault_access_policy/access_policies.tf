module "logged_in_user" {
  source = "./access_policy"
  keyvault_id = var.keyvault_id == null
  tenant_id     = var.global_settings.tenant_id
  access_policies = try(var.access_policies,null)
  object_id     = var.global_settings.object_id
  key_permissions = local.all_key_permissions
  secret_permissions = local.all_secret_permissions
}


module "managed_identities" {
  source = "./access_policy"
  for_each = length(try(var.access_policies.managed_identity_refs, [])) > 0 ? var.access_policies.managed_identity_refs : {}
  keyvault_id = var.keyvault_id == null
  access_policies = var.access_policies
  tenant_id     = var.global_settings.tenant_id
  object_id     = var.resources.managed_identities[each.value].id
  key_permissions = local.effective_key_permissions
  secret_permissions = local.effective_secret_permissions
}
