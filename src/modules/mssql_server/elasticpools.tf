# resource "azurerm_mssql_elasticpool" "main" {
#   for_each = try(var.settings.elasticpools, {})

#   name                       = each.value.name
#   server_name = azurerm_mssql_server.main.name
#   resource_group_name                          = local.resource_group_name
#   location                                     = local.location
#   maintenance_configuration_name = try(each.value.maintenance_configuration_name, null)
#   max_size_gb = try(each.value.max_size_gb, null)
#   max_size_bytes = try(each.value.max_size_bytes, null)
#   enclave_type = try(each.value.enclave_type, null)
#   zone_redundant = try(each.value.zone_redundant, null)
#   license_type = try(each.value.license_type, null)
#   tags = local.tags

#   sku {
#     name = each.value.sku.name
#     capacity = each.value.sku.capacity
#     tier = each.value.sku.tier
#     family = try(each.value.sku.tier, null)
#   }

#   per_database_settings {
#     min_capacity = each.value.per_database_settings.min_capacity
#     max_capacity = each.value.per_database_settings.max_capacity
#   }
# }
