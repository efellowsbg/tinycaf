resource "azurerm_subscription" "main" {
  subscription_name = var.settings.subscription_name
  alias             = try(var.settings.alias, null)
  billing_scope_id  = try(var.settings.billing_scope_id, null)
  subscription_id   = try(var.settings.subscription_id, null)
  workload          = try(var.settings.workload, null)
  tags              = local.tags
}
