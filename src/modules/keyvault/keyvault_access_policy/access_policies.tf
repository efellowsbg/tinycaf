module "managed_identity" {
  source = "./access_policy"
  count = local.has_logged_in_key ? 1 : 0

  keyvault_id = var.keyvault_id == null

  access_policy = each.value
  tenant_id     = var.global_settings.tenant_id
  object_id     = var.global_settings.object_id
}
