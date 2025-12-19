resource "azurerm_managed_disk" "data" {
  for_each = try(var.settings.data_disks, {})

  name                              = try(each.value.name, "${var.settings.name}-data-disk-${each.key}")
  storage_account_type              = try(each.value.storage_account_type, "Standard_LRS")
  location                          = local.location
  resource_group_name               = local.resource_group_name
  create_option                     = each.value.create_option
  disk_encryption_set_id            = try(each.value.disk_encryption_set_id, null)
  disk_iops_read_write              = try(each.value.disk_iops_read_write, null)
  disk_mbps_read_write              = try(each.value.disk_mbps_read_write, null)
  disk_iops_read_only               = try(each.value.disk_iops_read_only, null)
  disk_mbps_read_only               = try(each.value.disk_mbps_read_only, null)
  upload_size_bytes                 = try(each.value.upload_size_bytes, null)
  disk_size_gb                      = try(each.value.disk_size_gb, null)
  edge_zone                         = try(each.value.edge_zone, null)
  hyper_v_generation                = try(each.value.hyper_v_generation, null)
  image_reference_id                = try(each.value.image_reference_id, null)
  gallery_image_reference_id        = try(each.value.gallery_image_reference_id, null)
  logical_sector_size               = try(each.value.logical_sector_size, null)
  optimized_frequent_attach_enabled = try(each.value.optimized_frequent_attach_enabled, null)
  performance_plus_enabled          = try(each.value.performance_plus_enabled, null)
  os_type                           = try(each.value.os_type, null)
  source_resource_id                = try(each.value.source_resource_id, null)
  source_uri                        = try(each.value.source_uri, null)
  tier                              = try(each.value.tier, null)
  max_shares                        = try(each.value.max_shares, null)
  trusted_launch_enabled            = try(each.value.trusted_launch_enabled, null)
  security_type                     = try(each.value.security_type, null)
  secure_vm_disk_encryption_set_id  = try(each.value.secure_vm_disk_encryption_set_id, null)
  on_demand_bursting_enabled        = try(each.value.on_demand_bursting_enabled, null)
  zone                              = try(each.value.zone, null)
  network_access_policy             = try(each.value.network_access_policy, null)
  disk_access_id                    = try(each.value.disk_access_id, null)
  public_network_access_enabled     = try(each.value.public_network_access_enabled, null)

  storage_account_id = try(
    var.resources[
      try(var.settings.stacc_lz_key, var.client_config.landingzone_key)
    ].storage_accounts[each.value.storage_account_ref].id,
    each.value.storage_account_id,
    null
  )

  tags = {
    environment = "staging"
  }

  dynamic "encryption_settings" {
    for_each = can(each.value.encryption_settings) ? [1] : []
    content {
      disk_encryption_key {
        secret_url = each.value.encryption_settings.disk_encryption_key.secret_url
        source_vault_id = try(
          var.resources[
            try(each.value.encryption_settings.disk_encryption_key.kv_lz_key, var.client_config.landingzone_key)
          ].keyvaults[each.value.encryption_settings.disk_encryption_key.kv_ref].id,
          each.value.encryption_settings.disk_encryption_key.source_vault_id,
          null
        )
      }
      dynamic "key_encryption_key" {
        for_each = can(each.value.encryption_settings.key_encryption_key) ? [1] : []
        content {
          key_url = each.value.encryption_settings.key_encryption_key.key_url
          source_vault_id = try(
            var.resources[
              try(each.value.encryption_settings.key_encryption_key.kv_lz_key, var.client_config.landingzone_key)
            ].keyvaults[each.value.encryption_settings.key_encryption_key.kv_ref].id,
            each.value.encryption_settings.key_encryption_key.source_vault_id,
            null
          )
        }
      }
    }
  }
}
