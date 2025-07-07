resource "azurerm_linux_virtual_machine" "main" {
  name                  = var.settings.name
  resource_group_name   = local.resource_group_name
  location              = local.location
  admin_username        = var.settings.admin_username
  size                  = var.settings.size
  network_interface_ids = local.network_interface_ids

  tags = local.tags

  dynamic "admin_ssh_key" {
    for_each = try(var.settings.admin_ssh_key, {})
    content {
      username   = admin_ssh_key.value.username
      public_key = tls_private_key.main[admin_ssh_key.value.public_key_ref].public_key_openssh
    }
  }

  os_disk {
    caching                   = var.settings.os_disk.caching
    disk_size_gb              = try(var.settings.os_disk.disk_size_gb, null)
    storage_account_type      = var.settings.os_disk.storage_account_type
    write_accelerator_enabled = try(var.settings.os_disk.write_accelerator_enabled, false)
    disk_encryption_set_id    = can(var.settings.os_disk.disk_encryption_set_key) ? var.resources.disk_encryption_sets[var.settings.os_disk.disk_encryption_set_key].id : null
  }

  source_image_reference {
    publisher = var.settings.source_image_reference.publisher
    offer     = var.settings.source_image_reference.offer
    sku       = var.settings.source_image_reference.sku
    version   = var.settings.source_image_reference.version
  }
}
