locals {
  local_resource_groups    = azurerm_resource_group.main
  local_managed_identities = azurerm_user_assigned_identity.main

  local_users = module.users
}

locals {
  objects = {
    resource_groups    = local.local_resource_groups
    managed_identities = local.local_managed_identities

    users = local.local_users
  }
}
