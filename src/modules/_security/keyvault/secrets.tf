module "secrets" {
  source = "./keyvault_secret"

  # Use for_each to iterate over the secrets map
  for_each = try(var.settings.secrets, {})

  settings        = var.settings
  keyvault_id     = azurerm_key_vault.main.id
  secrets         = each.value
  global_settings = var.global_settings
  resources       = var.resources
}
