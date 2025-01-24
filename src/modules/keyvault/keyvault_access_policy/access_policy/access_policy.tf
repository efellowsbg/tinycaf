resource "azurerm_key_vault_access_policy" "main" { # Using the policy key in the resource name
  key_vault_id = var.keyvault_id

  tenant_id = var.tenant_id
  object_id = var.object_id

  key_permissions    = var.key_permissions
  secret_permissions = var.secret_permissions
}
