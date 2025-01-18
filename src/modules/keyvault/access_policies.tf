module "initial_policy" {
  source          = "./keyvault_access_policy"
  count           = try(length(var.settings.access_policies), 0) > 0 ? 1 : 0

  settings        = var.settings
  keyvault_id     = azurerm_key_vault.main.id
  access_policies = var.settings.access_policies
  global_settings = var.global_settings
}
