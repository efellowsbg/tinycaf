resource "hcloud_network_route" "main" {
  network_id  = local.network_id
  destination = var.settings.destination
  gateway     = var.settings.gateway
}
