module "initial_policy" {
  source          = "./keyvault_access_policy"
  for_each        = try(var.settings.access_policies, {})
  settings        = var.settings
  global_settings = var.global_settings

  keyvault_id     = azurerm_key_vault.main.id
  access_policies = each.value
  policy_name     = each.key

  resources = var.resources
  client_config = var.client_config
}
