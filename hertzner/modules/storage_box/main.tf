resource "hcloud_storage_box" "main" {
  name             = var.settings.name
  location         = var.settings.location
  storage_box_type = var.settings.storage_box_type
  password         = var.settings.password

  labels = local.labels

  delete_protection = try(var.settings.delete_protection, false)
  ssh_keys          = try(var.settings.ssh_keys, null)

  dynamic "access_settings" {
    for_each = can(var.settings.access_settings) ? [1] : []
    content {
      reachable_externally = try(var.settings.access_settings.reachable_externally, null)
      samba_enabled        = try(var.settings.access_settings.samba_enabled, null)
      ssh_enabled          = try(var.settings.access_settings.ssh_enabled, null)
      webdav_enabled       = try(var.settings.access_settings.webdav_enabled, null)
      zfs_enabled          = try(var.settings.access_settings.zfs_enabled, null)
    }
  }

  dynamic "snapshot_plan" {
    for_each = can(var.settings.snapshot_plan) ? [1] : []
    content {
      hour           = var.settings.snapshot_plan.hour
      max_snapshots  = var.settings.snapshot_plan.max_snapshots
      minute         = var.settings.snapshot_plan.minute
      day_of_month   = try(var.settings.snapshot_plan.day_of_month, null)
      day_of_week    = try(var.settings.snapshot_plan.day_of_week, null)
    }
  }
}
