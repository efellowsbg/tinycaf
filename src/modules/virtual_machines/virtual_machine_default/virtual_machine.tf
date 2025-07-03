resource "azurerm_virtual_machine" "main" {
  name                  = var.settings.name
  location              = local.location
  resource_group_name   = local.resource_group_name
  network_interface_ids = local.network_interface_ids
  vm_size               = var.settings.size
  tags                  = local.tags

  delete_os_disk_on_termination    = try(var.settings.delete_os_disk_on_termination, true)
  delete_data_disks_on_termination = try(var.settings.delete_data_disks_on_termination, true)

  dynamic "os_profile" {
    for_each = can(var.settings.os_profile) ? [1] : []
    content {
      computer_name  = var.settings.os_profile.name
      admin_username = var.settings.os_profile.admin_username
      admin_password = try(random_password.admin.result, var.settings.os_profile.admin_password, null)
    }
  }

  dynamic "os_profile_windows_config" {
    for_each = can(var.settings.os_profile_windows_config) ? [1] : []
    content {
      provision_vm_agent        = try(var.settings.os_profile_windows_config.provision_vm_agent, false)
      enable_automatic_upgrades = try(var.settings.os_profile_windows_config.enable_automatic_upgrades, false)
      timezone                  = try(var.settings.os_profile_windows_config.timezone, null)
      dynamic "winrm" {
        for_each = try(var.settings.os_profile.winrm, [])
        content {
          protocol        = try(winrm.value.protocol, null)
          certificate_url = try(winrm.value.certificate_url, null)
        }
      }
    }
  }

  dynamic "os_profile_linux_config" {
    for_each = can(var.settings.os_profile_linux_config) ? [1] : []
    content {
      disable_password_authentication = try(var.settings.os_profile_linux_config.disable_password_authentication, false)
      dynamic "ssh_keys" {
        for_each = try(var.settings.os_profile_linux_config.ssh_keys, {})
        content {
          path     = try(var.settings.os_profile_linux_config.ssh_keys.path, null)
          key_data = try(var.settings.os_profile_linux_config.ssh_keys.key_data, null)
        }
      }
    }
  }

  dynamic "storage_os_disk" {
    for_each = can(var.settings.storage_os_disk) ? [1] : []
    content {
      name                      = try(var.settings.storage_os_disk.name, "${var.settings.name}-osdisk")
      caching                   = try(var.settings.storage_os_disk.caching, null)
      create_option             = try(var.settings.storage_os_disk.create_option, "FromImage")
      managed_disk_type         = try(var.settings.storage_os_disk.managed_disk_type, null)
      managed_disk_id           = try(var.settings.storage_os_disk.managed_disk_id, null)
      os_type                   = try(var.settings.storage_os_disk.os_type, null)
      disk_size_gb              = try(var.settings.storage_os_disk.disk_size_gb, null)
      image_uri                 = try(var.settings.storage_os_disk.image_uri, null)
      write_accelerator_enabled = try(var.settings.storage_os_disk, null)
    }
  }

  dynamic "storage_image_reference" {
    for_each = can(var.settings.storage_image_reference) ? [1] : []
    content {
      publisher = try(var.settings.storage_image_reference.publisher, null)
      offer     = try(var.settings.storage_image_reference.offer, null)
      sku       = try(var.settings.storage_image_reference.sku, null)
      version   = try(var.settings.storage_image_reference.version, null)
    }
  }

  dynamic "identity" {
    for_each = can(var.settings.identity) ? [1] : []

    content {
      type         = var.settings.identity.type
      identity_ids = try(local.identity_ids, null)
    }
  }
}

resource "random_password" "admin" {
  for_each         = can(var.settings.os_profile.keyvault_ref) ? { "admin" = true } : {}
  length           = 123
  min_upper        = 2
  min_lower        = 2
  min_special      = 2
  numeric          = true
  special          = true
  override_special = "!@#$%&"
}


resource "azurerm_key_vault_secret" "admin_password" {
  for_each     = can(var.settings.os_profile.keyvault_ref) ? { "admin_password" = true } : {}
  name         = "${var.settings.name}-${var.settings.os_profile.admin_username}"
  value        = random_password.admin["admin"].result
  key_vault_id = local.key_vault_id
}
