module "diagnostic_settings" {
  source          = "./../diagnostic_setting"
  for_each        = try(var.settings.diagnostic_settings, {})
  settings        = each.value
  global_settings = var.global_settings

  resource_id = azurerm_key_vault.main.id

  resources     = var.resources
  client_config = var.client_config
}
