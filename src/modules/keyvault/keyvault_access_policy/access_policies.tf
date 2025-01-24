module "object_ids" {
  source   = "./access_policy"
  for_each = var.policy_name == "object_ids" && length(try(var.access_policies.object_ids, [])) > 0 ? { for idx, obj_id in try(var.access_policies.object_ids, []) : idx => obj_id } : {}

  keyvault_id        = var.keyvault_id
  access_policies    = var.access_policies
  tenant_id          = var.global_settings.tenant_id
  object_id          = each.value
  key_permissions    = local.effective_key_permissions
  secret_permissions = local.effective_secret_permissions
}
