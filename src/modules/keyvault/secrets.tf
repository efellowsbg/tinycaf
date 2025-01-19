module "secrets" {
  source          = "./keyvault_secret"
  for_each        = try(var.settings.secrets, {})

  settings        = var.settings
  keyvault_id     = azurerm_key_vault.main.id
  secrets = each.value
  global_settings = var.global_settings
  resources = var.resources
}
