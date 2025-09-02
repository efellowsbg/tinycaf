resource "azurerm_virtual_machine" "main" {
  name                  = var.settings.name
  location              = local.location
  resource_group_name   = local.resource_group_name
  network_interface_ids = local.network_interface_ids
  vm_size               = var.settings.size

  delete_os_disk_on_termination    = try(var.settings.delete_os_disk_on_termination, null)
  delete_data_disks_on_termination = try(var.settings.delete_data_disks_on_termination, null)
  primary_network_interface_id     = try(module.network_interface.ids[0], null)
  dynamic "os_profile" {
    for_each = can(var.settings.os_profile) ? [1] : []
    content {
      computer_name  = var.settings.os_profile.name
      admin_username = var.settings.os_profile.admin_username
      admin_password = try(random_password.admin["admin"].result, var.settings.os_profile.admin_password, null)
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
    for_each = local.create_managed_disk ? [1] : []
    content {
      name                      = try(var.settings.storage_os_disk.name, "${var.settings.name}-osdisk")
      caching                   = try(var.settings.storage_os_disk.caching, "ReadWrite")
      create_option             = try(var.settings.storage_os_disk.create_option, "Attach")
      os_type                   = try(var.settings.storage_os_disk.os_type, null)
      image_uri                 = try(var.settings.storage_os_disk.image_uri, null)
      write_accelerator_enabled = try(var.settings.storage_os_disk.write_accelerator_enabled, null)

      managed_disk_type = try(var.settings.storage_os_disk.managed_disk_type, null)
      managed_disk_id = (
        var.settings.storage_os_disk.config_drift && var.settings.storage_os_disk.managed_disk_small_letters
        ? lower(one(data.azurerm_managed_disk.main[*].id))
        : var.settings.storage_os_disk.config_drift
        ? one(data.azurerm_managed_disk.main[*].id)
        : one(azurerm_managed_disk.main[*].id)
      )

      vhd_uri = null
    }
  }
  dynamic "storage_os_disk" {
    for_each = local.create_managed_disk ? [] : [1]
    content {
      name                      = try(var.settings.storage_os_disk.name, "${var.settings.name}-osdisk")
      caching                   = try(var.settings.storage_os_disk.caching, null)
      create_option             = try(var.settings.storage_os_disk.create_option, "FromImage")
      managed_disk_type         = try(var.settings.storage_os_disk.managed_disk_type, null)
      managed_disk_id           = try(var.settings.storage_os_disk.managed_disk_id, null)
      os_type                   = try(var.settings.storage_os_disk.os_type, null)
      disk_size_gb              = try(var.settings.storage_os_disk.disk_size_gb, null)
      image_uri                 = try(var.settings.storage_os_disk.image_uri, null)
      write_accelerator_enabled = try(var.settings.storage_os_disk.write_accelerator_enabled, null)
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

  dynamic "storage_data_disk" {
    for_each = try(var.settings.storage_data_disk, {})
    content {
      name                      = try(storage_data_disk.value.name, "${var.settings.name}-datadisk-${storage_data_disk.key}")
      lun                       = try(storage_data_disk.value.lun, null)
      caching                   = try(storage_data_disk.value.caching, null)
      create_option             = try(storage_data_disk.value.create_option, "Empty")
      managed_disk_type         = try(storage_data_disk.value.managed_disk_type, null)
      disk_size_gb              = try(storage_data_disk.value.disk_size_gb, null)
      write_accelerator_enabled = try(storage_data_disk.value.write_accelerator_enabled, null)
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


resource "azurerm_managed_disk" "main" {
  count = local.create_managed_disk ? 1 : 0

  name                 = try(var.settings.storage_os_disk.name, "${var.settings.name}-osdisk")
  location             = local.resource_group.location
  resource_group_name  = (try(var.settings.storage_os_disk.use_capital_on_rg, false) ? upper(local.resource_group.name) : local.resource_group.name)
  storage_account_type = try(var.settings.storage_os_disk.managed_disk_type, "Standard_LRS")
  create_option        = try(var.settings.storage_os_disk.disk_create_option, "Attach")
  disk_size_gb         = try(var.settings.storage_os_disk.disk_size_gb, 30)
  hyper_v_generation   = try(var.settings.storage_os_disk.hyper_v_generation, null)
  source_resource_id   = try(var.settings.storage_os_disk.source_disk_id, null)
  tags                 = local.tags
  os_type              = try(var.settings.storage_os_disk.os_type, null)
}

data "azurerm_managed_disk" "main" {
  count               = try(var.settings.storage_os_disk.config_drift, false) ? 1 : 0
  name                = var.settings.storage_os_disk.name
  resource_group_name = local.resource_group_name
}

resource "random_password" "admin" {
  for_each         = can(var.settings.os_profile.keyvault_ref) ? { "admin" = true } : {}
  length           = 30
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


resource "azurerm_mssql_virtual_machine" "main" {
  for_each                         = can(var.settings.mssql_vm) ? var.settings.mssql_vm : {}
  virtual_machine_id               = azurerm_virtual_machine.main.id
  sql_license_type                 = try(each.value.sql_license_type, "PAYG")
  r_services_enabled               = try(each.value.r_services_enabled, false)
  sql_connectivity_port            = try(each.value.sql_connectivity_port, 1433)
  sql_connectivity_type            = try(each.value.sql_connectivity_type, "PRIVATE")
  sql_connectivity_update_password = try(each.value.sql_connectivity_update_password, null)
  sql_connectivity_update_username = try(each.value.sql_connectivity_update_username, null)
  dynamic "auto_backup" {
    for_each = can(each.value.auto_backup) ? [1] : []
    content {
      retention_period_in_days   = try(each.value.auto_backup.retention_period_in_days, null)
      storage_account_access_key = try(each.value.auto_backup.storage_account_access_key, null)
      storage_blob_endpoint      = try(each.value.auto_backup.storage_blob_endpoint, null)
    }
  }
}
