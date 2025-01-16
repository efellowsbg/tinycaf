module "initial_policy" {
  source = "../keyvault_access_policies"
  count  = try(var.settings.creation_policies, null) == null ? 0 : 1

  keyvault_id     = azurerm_key_vault.main.id
  access_policies = var.settings.creation_policies
  client_config   = var.client_config
  resources = {
    managed_identities = var.managed_identities
  }
}

# Introduce a conditional delay using time_sleep for policy updates
resource "time_sleep" "initial_policy_delay" {
  count      = try(var.settings["enable_policy_update_delay"], var.enable_policy_update_delay, false) ? 1 : 0
  depends_on = [module.initial_policy]

  create_duration = "15s"
}