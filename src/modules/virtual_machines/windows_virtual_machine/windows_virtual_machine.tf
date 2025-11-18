resource "azurerm_windows_virtual_machine" "main" {
  name                  = var.settings.name
  resource_group_name   = local.resource_group_name
  location              = local.location
  admin_username        = var.settings.admin_username
  computer_name         = try(var.settings.computer_name, null)
  admin_password        = random_password.admin.result
  size                  = var.settings.size
  network_interface_ids = local.network_interface_ids
  tags                  = local.tags
  dynamic "plan" {
    for_each = can(var.settings.plan) ? [1] : []
    content {
      name      = var.settings.plan.name
      product   = var.settings.plan.product
      publisher = var.settings.plan.publisher
    }
  }
  os_disk {
    caching              = var.settings.os_disk.caching
    storage_account_type = var.settings.os_disk.storage_account_type
    disk_size_gb         = try(var.settings.os_disk.disk_size_gb, null)
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
      identity_ids = local.identity_ids
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
  length           = try(var.settings.password_settings.length, 123)
  min_upper        = try(var.settings.password_settings.min_upper, 2)
  min_lower        = try(var.settings.password_settings.min_lower, 2)
  min_special      = try(var.settings.password_settings.min_special, 2)
  numeric          = try(var.settings.password_settings.numeric, true)
  special          = try(var.settings.password_settings.special, true)
  override_special = try(var.settings.password_settings.override_special, "!@#$%&")
}

resource "azurerm_key_vault_secret" "admin_password" {
  name         = try(var.settings.custom_secret_name, "${var.settings.name}-${var.settings.admin_username}")
  value        = random_password.admin.result
  key_vault_id = local.key_vault_id
}
