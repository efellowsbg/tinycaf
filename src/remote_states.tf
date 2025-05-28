module "remote_states" {
  for_each = try(var.landingzone.tfstates, {})

  source               = "./modules/remote_state"
  backend_type         = var.landingzone.backend_type
  tfstate              = each.value.tfstate
  resource_group_name  = var.landingzone.backend_config.resource_group_name
  storage_account_name = var.landingzone.backend_config.storage_account_name
  container_name       = var.landingzone.backend_config.container_name
  client_id            = var.client_id
  tenant_id            = var.tenant_id
  remote_state_subscription_id = var.remote_state_subscription_id
}
