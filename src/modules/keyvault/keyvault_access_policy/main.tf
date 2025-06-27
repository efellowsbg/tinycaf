module "access_policy" {
  source   = "./access_policy"
  for_each = { for item in local.normalized_access_policies : item.key => item }

  keyvault_id             = var.keyvault_id
  tenant_id               = var.global_settings.tenant_id
  object_id               = each.value.object_id
  key_permissions         = each.value.key_permissions
  secret_permissions      = each.value.secret_permissions
  certificate_permissions = each.value.certificate_permissions
  storage_permissions     = each.value.storage_permissions
}