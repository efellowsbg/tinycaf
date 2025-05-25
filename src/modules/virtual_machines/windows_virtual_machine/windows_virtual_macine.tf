resource "azurerm_windows_virtual_machine" "main" {
  name                              = var.settings.name
  resource_group_name               = local.resource_group_name
  location                          = local.location
  admin_username                    = var.settings.admin_username
  admin_password                    = random_password.admin.result
  size                              = var.settings.size
  network_interface_ids             = local.network_interface_ids
  vm_agent_platform_updates_enabled = try(var.settings.vm_agent_platform_updates_enabled, false)
  tags                              = local.tags

  os_disk {
    caching              = var.settings.os_disk.caching
    storage_account_type = var.settings.os_disk.storage_account_type
    disk_encryption_set_id = can(var.settings.os_disk.disk_encryption_set_key) ? var.resources[
      try(var.settings.os_disk.disk_encryption_set_lz_key, var.client_config.landingzone_key)
      ].disk_encryption_sets[
      var.settings.os_disk.disk_encryption_set_key
    ].id : null

  }
  dynamic "identity" {
    for_each = can(var.settings.identity) ? [1] : []

    content {
      type         = var.settings.identity.type
      identity_ids = try(local.identity_ids, null)
    }
  }
  source_image_reference {
    publisher = var.settings.source_image_reference.publisher
    offer     = var.settings.source_image_reference.offer
    sku       = var.settings.source_image_reference.sku
    version   = var.settings.source_image_reference.version
  }
}

resource "random_password" "admin" {
  length           = 123
  min_upper        = 2
  min_lower        = 2
  min_special      = 2
  numeric          = true
  special          = true
  override_special = "!@#$%&"
}


resource "azurerm_key_vault_secret" "admin_password" {
  name         = "${var.settings.name}-${var.settings.admin_username}"
  value        = random_password.admin.result
  key_vault_id = local.key_vault_id
}
