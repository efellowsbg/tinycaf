resource "azurerm_key_vault_certificate" "main" {
  name         = var.certificate.name
  key_vault_id = var.keyvault_id
  certificate {
    contents = data.azurerm_key_vault_secret.main.value
    password = try(var.certificate.password, "")
  }
}

data "azurerm_key_vault_secret" "main" {
  name         = var.certificate.secret_name
  key_vault_id = var.keyvault_id
}

output "secret_value" {
  value     = data.azurerm_key_vault_secret.main.value
  sensitive = true
}
