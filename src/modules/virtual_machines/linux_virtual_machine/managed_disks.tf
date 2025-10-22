resource "azurerm_managed_disk" "main" {
  for_each = try(var.settings.data_disks, {})

  name                 = each.value.name
  location             = local.location
  resource_group_name  = local.resource_group_name
  storage_account_type = try(each.value.storage_account_type, "Standard_LRS")
  create_option        = try(each.value.create_option, "Empty")
  disk_size_gb         = try(each.value.disk_size_gb, 10)
  zone                 = try(each.value.zone, null)
  tier                 = try(each.value.tier, null)
  tags                 = local.tags
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
