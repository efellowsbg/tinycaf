resource "azurerm_linux_virtual_machine" "main" {
  name                  = var.settings.name
  resource_group_name   = local.resource_group_name
  location              = local.location
  admin_username        = var.settings.admin_username
  size                  = var.settings.size
  network_interface_ids = local.network_interface_ids

  tags = local.tags

  dynamic "admin_ssh_key" {
    for_each = try(var.settings.admin_ssh_key[*], {})
    content {
      username   = try(admin_ssh_key.value.username, null)
      public_key = try(admin_ssh_key.value.public_key, null)
    }
  }

  os_disk {
    caching              = var.settings.os_disk.caching
    storage_account_type = var.settings.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = var.settings.source_image_reference.publisher
    offer     = var.settings.source_image_reference.offer
    sku       = var.settings.source_image_reference.sku
    version   = var.settings.source_image_reference.version
  }
}
