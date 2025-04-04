locals {
  global_settings = merge(var.global_settings, {
    object_id       = data.azurerm_client_config.current.object_id
    subscription_id = data.azurerm_client_config.current.subscription_id
    tenant_id       = data.azurerm_client_config.current.tenant_id
    client_id       = data.azurerm_client_config.current.client_id
    ddos_protection_plan_id = "/subscriptions/3fc84f9a-af5a-410c-ad47-53ed236a6360/resourceGroups/rg-caf-ddos-sd-01/providers/Microsoft.Network/ddosProtectionPlans/ddos-plan-shd-eu2-01"
  })
}
