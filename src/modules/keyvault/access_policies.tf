# Initial policy is used to address a a bootstrap condition during the launchpad deployment
module "initial_policy" {
  source = "./keyvault_access_policy"
  for_each = try(var.settings.access_policies, {}) != {} ? var.settings.access_policies : {}
  settings        = each.value
  keyvault_id     = azurerm_key_vault.main.id
  access_policies = var.settings.access_policies
  global_settings = var.global_settings
}
