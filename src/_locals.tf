locals {
  client_config = var.client_config == {} ? {
    client_id               = var.client_config.client_id
    logged_aad_app_objectId = local.object_id
    logged_user_objectId    = local.object_id
    object_id               = local.object_id
    subscription_id         = var.subscription_id
    tenant_id               = var.tenant_id
  } : map(var.client_config)

  object_id = try(var.logged_user_objectId, null )
}