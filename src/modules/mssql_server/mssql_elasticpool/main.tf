resource "azurerm_mssql_elasticpool" "main" {
  name                           = try(var.elasticpools.name, var.elastic_name)
  server_name                    = var.mssql_server_name
  resource_group_name            = local.resource_group_name
  location                       = local.location
  maintenance_configuration_name = try(var.elasticpools.maintenance_configuration_name, null)
  max_size_gb                    = try(var.elasticpools.max_size_gb, null)
  max_size_bytes                 = try(var.elasticpools.max_size_bytes, null)
  enclave_type                   = try(var.elasticpools.enclave_type, null)
  zone_redundant                 = try(var.elasticpools.zone_redundant, null)
  license_type                   = try(var.elasticpools.license_type, null)
  tags                           = try(var.elasticpools.tags, local.tags)

  sku {
    name     = var.elasticpools.sku.name
    capacity = var.elasticpools.sku.capacity
    tier     = var.elasticpools.sku.tier
    family   = try(var.elasticpools.sku.family, null)
  }

  per_database_settings {
    min_capacity = var.elasticpools.per_database_settings.min_capacity
    max_capacity = var.elasticpools.per_database_settings.max_capacity
  }
}
