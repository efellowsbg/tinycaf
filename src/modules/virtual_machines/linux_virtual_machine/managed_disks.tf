resource "azurerm_managed_disk" "main" {
  for_each             = try(var.settings.data_disks, {})

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

  managed_disk_id   = azurerm_managed_disk.main[each.key].id
  virtual_machine_id = azurerm_linux_virtual_machine.main.id
  lun                = each.value.lun
  write_accelerator_enabled = try(each.value.write_accelerator_enabled, null)
  caching            = try(each.value.caching, "None")
  create_option      = try(each.value.create_option_on_attach, null)
}