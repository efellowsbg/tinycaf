module "storage_account_endpoint" {
  source = "./private_endpoint"

  count = try(var.settings.private_endpoint != null, false) ? 1 : 0

  settings            = var.settings
  storage_acccount_id = azurerm_storage_account.main.id
  subnet_ref          = var.settings.private_endpoint.subnet_ref
  dns_zones_ref       = var.settings.private_endpoint.dns_zones_ref
  global_settings     = var.global_settings
  resources           = var.resources
  client_config       = var.client_config
}
