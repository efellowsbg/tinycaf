module "initial_policy" {
  source = "../keyvault_access_policies"
  count  = try(var.settings.creation_policies, null) == null ? 0 : 1
  keyvault_id     = azurerm_key_vault.main.id
  client_config   = var.client_config
  resources = {
    managed_identities = module.managed_identity
  }
}

# Introduce a conditional delay using time_sleep for policy updates
resource "time_sleep" "initial_policy_delay" {
  count      = try(var.settings["enable_policy_update_delay"], var.enable_policy_update_delay, false) ? 1 : 0
  depends_on = [module.initial_policy]

  create_duration = "15s"
}



module "logged_in_user" {
  source = "../keyvault_access_policies/access_policy"
  access_policies = var.settings.creation_policies
  for_each = {
    for key, access_policy in  var.access_policies : key => access_policy
    if key == "logged_in_user" && var.client_config.logged_user_objectId != null
  }

  keyvault_id = var.keyvault_id == null ? var.resources.keyvaults[var.keyvault_key].id : var.keyvault_id

  access_policy = each.value
  tenant_id     = var.tenant_id
  object_id     = var.client_config.object_id
}

module "object_id" {
  source = "../keyvault_access_policies/access_policy"
  access_policies = var.settings.creation_policies
  for_each = {
    for key, access_policy in var.access_policies : key => access_policy
    if try(access_policy.object_id, null) != null && var.client_config.logged_aad_app_objectId != null
  }

  keyvault_id = var.keyvault_id == null ? var.resources.keyvaults[var.keyvault_key].id : var.keyvault_id

  access_policy = each.value
  tenant_id     = try(each.value.tenant_id, var.tenant_id)
  object_id     = each.value.object_id
}

module "managed_identity" {
  source = "../keyvault_access_policies/access_policy"
  access_policies = var.settings.creation_policies
  for_each = {
    for key, access_policy in var.access_policies : key => access_policy
    if try(access_policy.managed_identity_key, null) != null
  }

  keyvault_id = var.keyvault_id == null ? var.resources.keyvaults[var.keyvault_key].id : var.keyvault_id

  access_policy = each.value
  tenant_id     = var.tenant_id
  object_id     = var.resources.managed_identities[each.value.managed_identity_key].principal_id
}
