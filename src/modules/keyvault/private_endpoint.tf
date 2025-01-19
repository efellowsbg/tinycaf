module "keyvault_endpoint" {
  source = "./keyvault_private_endpoint"

  count = var.settings.private_endpoint != null ? 1 : 0

  settings        = var.settings
  keyvault_id     = azurerm_key_vault.main.id
  subnet_ref      = var.settings.private_endpoint.subnet_ref
  dns_zones_ref   = var.settings.private_endpoint.dns_zones_ref
  global_settings = var.global_settings
  resources       = var.resources
}
