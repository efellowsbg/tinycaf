resource "azurerm_key_vault_access_policy" "logged_in_user" {

  key_vault_id            = var.keyvault_id
  tenant_id               = var.tenant_id
  object_id               = var.object_id
  key_permissions         = try(var.key_permissions, null)
  secret_permissions      = try(var.secret_permissions, null)

  timeouts {
    delete = "60m"
  }
}


resource "azurerm_key_vault_access_policy" "main" { # Using the policy key in the resource name
  key_vault_id = var.keyvault_id

  tenant_id    = var.tenant_id
  object_id    = var.object_id

  key_permissions    = var.key_permissions
  secret_permissions = var.secret_permissions
}
