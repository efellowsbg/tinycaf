resource "azurerm_managed_disk" "main" {
  name                 = var.settings.name
  resource_group_name  = local.resource_group_name
  location             = local.location
  storage_account_type = try(var.settings.storage_account_type, "Standard_LRS")
  create_option        = try(var.settings.create_option, "Empty")
  disk_size_gb         = try(var.settings.disk_size_gb, "20")
  tags                 = local.tags
}
