resource "azurerm_linux_virtual_machine" "main" {
  name                            = var.settings.name
  resource_group_name             = local.resource_group_name
  location                        = local.location
  admin_username                  = try(var.settings.admin_username, null)
  admin_password                  = try(random_password.admin[0].result, null)
  size                            = var.settings.size
  network_interface_ids           = local.network_interface_ids
  encryption_at_host_enabled      = try(var.settings.encryption_at_host_enabled, null)
  disable_password_authentication = try(var.settings.disable_password_authentication, null)
  availability_set_id             = try(one(azurerm_availability_set.main[*].id), null)
  os_managed_disk_id              = try(local.create_managed_disk, false) ? azurerm_managed_disk.creation[*].id : null
  dynamic "identity" {
    for_each = can(var.settings.identity) ? [1] : []
    content {
      type         = var.settings.identity.type
      identity_ids = try(local.identity_ids, null)
    }
  }

  tags = local.tags

  dynamic "admin_ssh_key" {
    for_each = try(var.settings.admin_ssh_key, {})
    content {
      username   = admin_ssh_key.value.username
      public_key = tls_private_key.main[admin_ssh_key.value.public_key_ref].public_key_openssh
    }
  }
  dynamic "plan" {
    for_each = can(var.settings.plan) ? [1] : []
    content {
      name      = var.settings.plan.name
      product   = var.settings.plan.product
      publisher = var.settings.plan.publisher
    }
  }
  os_disk {
    caching                   = var.settings.os_disk.caching
    disk_size_gb              = try(var.settings.os_disk.disk_size_gb, null)
    storage_account_type      = try(var.settings.os_disk.storage_account_type, null)
    write_accelerator_enabled = try(var.settings.os_disk.write_accelerator_enabled, false)
    disk_encryption_set_id    = can(var.settings.os_disk.disk_encryption_set_key) ? var.resources.disk_encryption_sets[var.settings.os_disk.disk_encryption_set_key].id : null
  }


  source_image_reference {
    publisher = var.settings.source_image_reference.publisher
    offer     = var.settings.source_image_reference.offer
    sku       = var.settings.source_image_reference.sku
    version   = var.settings.source_image_reference.version
  }
  timeouts {
    create = "60m"
    delete = "30m"
  }
}
