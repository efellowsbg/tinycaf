resource "azurerm_managed_disk" "main" {
  for_each = try(var.settings.data_disks, {})

  name                              = each.value.name
  location                          = local.location
  resource_group_name               = local.resource_group_name
  storage_account_type              = try(each.value.storage_account_type, "Standard_LRS")
  create_option                     = try(each.value.create_option, "Empty")
  disk_size_gb                      = try(each.value.disk_size_gb, 10)
  zone                              = try(each.value.zone, null)
  tier                              = try(each.value.tier, null)
  disk_encryption_set_id            = try(each.value.disk_encryption_set_id, null)
  disk_iops_read_write              = try(each.value.disk_iops_read_write, null)
  disk_mbps_read_write              = try(each.value.disk_mbps_read_write, null)
  disk_iops_read_only               = try(each.value.disk_iops_read_only, null)
  disk_mbps_read_only               = try(each.value.disk_mbps_read_only, null)
  upload_size_bytes                 = try(each.value.upload_size_bytes, null)
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
  max_shares                        = try(each.value.max_shares, null)
  trusted_launch_enabled            = try(each.value.trusted_launch_enabled, null)
  security_type                     = try(each.value.security_type, null)
  secure_vm_disk_encryption_set_id  = try(each.value.secure_vm_disk_encryption_set_id, null)
  on_demand_bursting_enabled        = try(each.value.on_demand_bursting_enabled, null)
  network_access_policy             = try(each.value.network_access_policy, null)
  disk_access_id                    = try(each.value.disk_access_id, null)
  public_network_access_enabled     = try(each.value.public_network_access_enabled, null)
  storage_account_id = try(
    var.resources[
      try(each.value.stacc_lz_key, var.client_config.landingzone_key)
    ].storage_accounts[each.value.storage_account_ref].id,
    each.value.storage_account_id,
    null
  )
  tags = try(each.value.tags, local.tags)
}

resource "azurerm_virtual_machine_data_disk_attachment" "main" {
  for_each = try(var.settings.data_disks, {})

  managed_disk_id           = azurerm_managed_disk.main[each.key].id
  virtual_machine_id        = azurerm_linux_virtual_machine.main.id
  lun                       = each.value.lun
  write_accelerator_enabled = try(each.value.write_accelerator_enabled, null)
  caching                   = try(each.value.caching, "None")
  create_option             = try(each.value.create_option_on_attach, null)
}

resource "azurerm_managed_disk" "creation" {
  count = local.create_managed_disk ? 1 : 0

  name                 = try(var.settings.os_disk.managed_disk.name, "${var.settings.name}-osdisk")
  location             = local.resource_group.location
  resource_group_name  = (try(var.settings.os_disk.managed_disk.use_capital_on_rg, false) ? upper(local.resource_group.name) : local.resource_group.name)
  storage_account_type = try(var.settings.os_disk.managed_disk.storage_account_type, "Standard_LRS")
  create_option        = try(var.settings.os_disk.managed_disk.create_option, "Attach")
  disk_size_gb         = try(var.settings.os_disk.managed_disk.disk_size_gb, 30)
  hyper_v_generation   = try(var.settings.os_disk.managed_disk.hyper_v_generation, null)
  source_resource_id   = try(var.settings.os_disk.managed_disk.source_disk_id, null)
  source_uri           = try(var.settings.os_disk.managed_disk.source_uri, null)
  storage_account_id = try(var.resources[
    try(var.settings.lz_key, var.client_config.landingzone_key)
  ].storage_accounts[var.settings.os_disk.managed_disk.storage_account_ref].id, null)
  tags    = local.tags
  os_type = try(var.settings.os_disk.managed_disk.os_type, null)
}
