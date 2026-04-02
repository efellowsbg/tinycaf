resource "hcloud_network_subnet" "main" {
  network_id   = local.network_id
  type         = var.settings.type
  ip_range     = var.settings.ip_range
  network_zone = var.settings.network_zone

  vswitch_id = try(var.settings.vswitch_id, null)
}
