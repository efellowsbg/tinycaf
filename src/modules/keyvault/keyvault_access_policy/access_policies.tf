module "logged_in_user" {
  source = "./access_policy"
  for_each = {
    for key, access_policy in var.settings : key => access_policy
    if key == "logged_in_user" && var.global_settings.object_id != null
  }

  keyvault_id = var.keyvault_id == null

  access_policy = each.value
  tenant_id     = var.global_settings.tenant_id
  object_id     = var.global_settings.object_id
}
