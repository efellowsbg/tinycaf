locals {
  global_settings = merge(var.global_settings, {
    object_id       = data.azurerm_client_config.current.object_id
    subscription_id = data.azurerm_client_config.current.subscription_id
    tenant_id       = data.azurerm_client_config.current.tenant_id
    client_id       = data.azurerm_client_config.current.client_id
  })
}


locals {
  resources = merge(
    { "${var.landingzone.key}" = module.caf },
    { for k, v in module.remote_states : k => v.outputs }
  )
}