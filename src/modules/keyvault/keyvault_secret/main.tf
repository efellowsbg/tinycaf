resource "azurerm_key_vault_secret" "main" {
  name         = var.secrets.name
  value        = tls_private_key.main.private_key_pem
  key_vault_id = var.keyvault_id

  lifecycle {
    ignore_changes = ["value"]
  }
}
