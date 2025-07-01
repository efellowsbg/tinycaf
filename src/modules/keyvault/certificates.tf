module "certificates" {
  source   = "./keyvault_certificate"
  for_each = try(var.settings.certificates, {})

  settings        = var.settings
  keyvault_id     = azurerm_key_vault.main.id
  certificate         = each.value
  global_settings = var.global_settings
  resources       = var.resources
  client_config   = var.client_config
}