resource "azurerm_resource_group" "main" {
  name     = var.settings.name
  location = var.settings.location

  tags = local.tags
}
