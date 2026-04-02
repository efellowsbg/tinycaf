resource "hcloud_storage_box_subaccount" "main" {
  storage_box_id = local.storage_box_id
  home_directory = var.settings.home_directory
  password       = var.settings.password

  name        = try(var.settings.name, null)
  description = try(var.settings.description, null)
  labels      = local.labels

  dynamic "access_settings" {
    for_each = can(var.settings.access_settings) ? [1] : []
    content {
      reachable_externally = try(var.settings.access_settings.reachable_externally, null)
      readonly             = try(var.settings.access_settings.readonly, null)
      samba_enabled        = try(var.settings.access_settings.samba_enabled, null)
      ssh_enabled          = try(var.settings.access_settings.ssh_enabled, null)
      webdav_enabled       = try(var.settings.access_settings.webdav_enabled, null)
    }
  }
}
