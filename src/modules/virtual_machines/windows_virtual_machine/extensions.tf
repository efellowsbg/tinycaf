resource "azurerm_virtual_machine_extension" "extension" {
  for_each = try(var.settings.extensions, {})

  name                       = each.value.name
  virtual_machine_id         = azurerm_windows_virtual_machine.main.id
  publisher                  = each.value.publisher
  type                       = each.value.type
  type_handler_version       = each.value.type_handler_version
  auto_upgrade_minor_version = try(each.value.auto_upgrade_minor_version, true)

  settings = try(each.value.settings, null)
  tags     = local.tags
}
