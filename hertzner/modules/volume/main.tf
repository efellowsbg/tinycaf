resource "hcloud_volume" "main" {
  name     = var.settings.name
  size     = var.settings.size
  location = try(var.settings.location, null)

  server_id = try(local.server_id, null)
  automount = try(var.settings.automount, null)
  format    = try(var.settings.format, null)

  labels = local.labels

  delete_protection = try(var.settings.delete_protection, false)
}
