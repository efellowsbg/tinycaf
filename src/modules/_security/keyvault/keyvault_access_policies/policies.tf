module "logged_in_user" {
  source = "./access_policy"
  for_each = {
    for key, access_policy in var.access_policies : key => access_policy
    if key == "logged_in_user" && var.client_config.logged_user_objectId != null
  }

  keyvault_id = var.keyvault_id == null ? var.resources.keyvaults[var.keyvault_key].id : var.keyvault_id

  access_policy = each.value
  tenant_id     = var.client_config.tenant_id
  object_id     = var.client_config.object_id
}

module "object_id" {
  source = "./access_policy"
  for_each = {
    for key, access_policy in var.access_policies : key => access_policy
    if try(access_policy.object_id, null) != null && var.client_config.logged_aad_app_objectId != null
  }

  keyvault_id = var.keyvault_id == null ? var.resources.keyvaults[var.keyvault_key].id : var.keyvault_id

  access_policy = each.value
  tenant_id     = try(each.value.tenant_id, var.client_config.tenant_id)
  object_id     = each.value.object_id
}

module "managed_identity" {
  source = "./access_policy"
  for_each = {
    for key, access_policy in var.access_policies : key => access_policy
    if try(access_policy.managed_identity_key, null) != null
  }

  keyvault_id = var.keyvault_id == null ? var.resources.keyvaults[var.keyvault_key].id : var.keyvault_id

  access_policy = each.value
  tenant_id     = var.client_config.tenant_id
  object_id     = var.resources.managed_identities[each.value.managed_identity_key].principal_id
}
