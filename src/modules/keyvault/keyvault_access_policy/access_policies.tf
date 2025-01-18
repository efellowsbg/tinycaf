module "logged_in_user" {
  source = "./access_policy"
  keyvault_id = var.keyvault_id == null

  tenant_id     = var.global_settings.tenant_id
  object_id     = var.global_settings.object_id
}


module "managed_identities" {
  source = "./access_policy"
  for_each = var.settings.access_policies.managed_identities
  keyvault_id = var.keyvault_id == null

  tenant_id     = var.global_settings.tenant_id
  object_id     = var.global_settings.object_id
}
