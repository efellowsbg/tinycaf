# resource "azurerm_storage_container" "main" {
#   for_each = try(var.settings.containers, {})

#   name               = each.value.name
#   storage_account_id = azurerm_storage_account.main.id

#   container_access_type = try(each.value.access_type, null)
# }
