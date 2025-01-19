module "keyvault_endpoint" {
  source          = "./keyvault_private_endpoint"
  for_each        = try(var.settings.private_endpoint != null ? { for k, v in var.settings.private_endpoint : k => v } : {})
  settings = var.settings
  keyvault_id     = azurerm_key_vault.main.id
  subnet_ref      = each.value.subnet_ref
  dns_zones_ref   = each.value.dns_zones_ref
  global_settings = var.global_settings
  resources       = var.resources
}
