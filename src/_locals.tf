locals {
  client_config = var.client_config == {} ? {
    client_id               = data.azuread_client_config.current.client_id
    logged_aad_app_objectId = local.object_id
    logged_user_objectId    = local.object_id
    object_id               = local.object_id
    subscription_id         = data.azurerm_client_config.current.subscription_id
    tenant_id               = data.azurerm_client_config.current.tenant_id
  } : map(var.client_config)

  object_id = coalesce(var.logged_user_objectId, var.logged_aad_app_objectId, try(data.azuread_client_config.current.object_id, null), try(data.azuread_service_principal.logged_in_app.0.object_id, null))
}