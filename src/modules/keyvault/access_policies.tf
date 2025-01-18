# Initial policy is used to address a a bootstrap condition during the launchpad deployment
module "initial_policy" {
  source = "./keyvault_access_policy"
  count  = try(var.settings.access_policies, null) == null ? 0 : 1
  settings        = each.value
  keyvault_id     = azurerm_key_vault.main.id
  access_policies = var.settings.access_policies
  global_settings = var.global_settings
}
