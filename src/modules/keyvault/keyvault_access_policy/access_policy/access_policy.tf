resource "azurerm_key_vault_access_policy" "logged_in_user" {

  key_vault_id            = var.keyvault_id
  tenant_id               = var.tenant_id
  object_id               = var.object_id
  key_permissions         = try(var.access_policy.key_permissions, null)
  secret_permissions      = try(var.access_policy.secret_permissions, null)
  certificate_permissions = try(var.access_policy.certificate_permissions, null)
  storage_permissions     = try(var.access_policy.storage_permissions, null)

  timeouts {
    delete = "60m"
  }
}


resource "azurerm_key_vault_access_policy" "example" {
  for_each = {
    for idx, mi in var.settings.access_policies.managed_identity.managed_identity_refs : "${idx}" => mi
  }

  key_vault_id = var.keyvault_id
  tenant_id    = var.tenant_id
  object_id    = var.resources.managed_identities[each.value].id

  key_permissions    = try(var.settings.access_policies.managed_identity.key_permissions,null)
  secret_permissions = try(var.settings.access_policies.managed_identity.secret_permissions,null)
}
