resource "azurerm_user_assigned_identity" "main" {
  name     = var.settings.name
  location = local.location
  resource_group_name = local.resource_group_name
}


