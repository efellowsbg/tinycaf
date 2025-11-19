resource "azurerm_managed_disk" "main" {
  name                              = var.settings.name
  resource_group_name               = local.resource_group_name
  location                          = local.location
  storage_account_type              = try(var.settings.storage_account_type, "Standard_LRS")
  create_option                     = try(var.settings.create_option, "Empty")
  disk_size_gb                      = try(var.settings.disk_size_gb, "20")
  disk_encryption_set_id            = try(var.settings.disk_encryption_set_id, null)
  disk_iops_read_write              = try(var.settings.disk_iops_read_write, null)
  disk_mbps_read_write              = try(var.settings.disk_mbps_read_write, null)
  disk_iops_read_only               = try(var.settings.disk_iops_read_only, null)
  disk_mbps_read_only               = try(var.settings.disk_mbps_read_only, null)
  upload_size_bytes                 = try(var.settings.upload_size_bytes, null)
  edge_zone                         = try(var.settings.edge_zone, null)
  hyper_v_generation                = try(var.settings.hyper_v_generation, null)
  image_reference_id                = try(var.settings.image_reference_id, null)
  gallery_image_reference_id        = try(var.settings.gallery_image_reference_id, null)
  logical_sector_size               = try(var.settings.logical_sector_size, null)
  optimized_frequent_attach_enabled = try(var.settings.optimized_frequent_attach_enabled, null)
  performance_plus_enabled          = try(var.settings.performance_plus_enabled, null)
  os_type                           = try(var.settings.os_type, null)
  source_resource_id                = try(var.settings.source_resource_id, null)
  source_uri                        = try(var.settings.source_uri, null)
  tier                              = try(var.settings.tier, null)
  max_shares                        = try(var.settings.max_shares, null)
  trusted_launch_enabled            = try(var.settings.trusted_launch_enabled, null)
  security_type                     = try(var.settings.security_type, null)
  secure_vm_disk_encryption_set_id  = try(var.settings.secure_vm_disk_encryption_set_id, null)
  on_demand_bursting_enabled        = try(var.settings.on_demand_bursting_enabled, null)
  zone                              = try(var.settings.zone, null)
  network_access_policy             = try(var.settings.network_access_policy, null)
  disk_access_id                    = try(var.settings.disk_access_id, null)
  public_network_access_enabled     = try(var.settings.public_network_access_enabled, null)
  storage_account_id                = local.storage_account_id
  tags                              = local.tags

  dynamic "encryption_settings" {
    for_each = can(var.settings.encryption_settings) ? [1] : []

    content {
      dynamic "disk_encryption_key" {
        for_each = can(var.settings.encryption_settings.disk_encryption_key) ? [1] : []
        content {
          secret_url = try(
            var.resources[
              try(var.settings.encryption_settings.disk_encryption_key.lz_key, var.client_config.landingzone_key)
            ].keyvaults[var.settings.encryption_settings.disk_encryption_key.keyvault_ref].secrets[var.settings.encryption_settings.disk_encryption_key.secret_ref].id,
            var.settings.encryption_settings.disk_encryption_key.secret_url
          )
          source_vault_id = try(
            var.resources[
              try(var.settings.encryption_settings.disk_encryption_key.lz_key, var.client_config.landingzone_key)
            ].keyvaults[var.settings.encryption_settings.disk_encryption_key.keyvault_ref].id,
            var.settings.encryption_settings.disk_encryption_key.source_vault_id
          )
        }
      }

      dynamic "key_encryption_key" {
        for_each = can(var.settings.encryption_settings.key_encryption_key) ? [1] : []
        content {
          key_url = try(
            var.resources[
              try(var.settings.encryption_settings.key_encryption_key.lz_key, var.client_config.landingzone_key)
            ].key_vault_keys[var.settings.encryption_settings.key_encryption_key.key_ref].versionless_id,
            var.settings.encryption_settings.key_encryption_key.key_url
          )
          source_vault_id = try(
            var.resources[
              try(var.settings.encryption_settings.key_encryption_key.lz_key, var.client_config.landingzone_key)
            ].keyvaults[var.settings.encryption_settings.key_encryption_key.keyvault_ref].id,
            var.settings.encryption_settings.key_encryption_key.key_source_vault_id
          )
        }
      }
    }
  }
}
