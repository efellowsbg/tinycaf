module "logged_in_user" {
  source = "./access_policy"
  for_each = var.settings

  keyvault_id = var.keyvault_id == null

  access_policy = each.value
  tenant_id     = var.global_settings.tenant_id
  object_id     = var.global_settings.object_id
}
