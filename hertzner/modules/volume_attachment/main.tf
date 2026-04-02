resource "hcloud_volume_attachment" "main" {
  volume_id = local.volume_id
  server_id = local.server_id
  automount = try(var.settings.automount, null)
}
