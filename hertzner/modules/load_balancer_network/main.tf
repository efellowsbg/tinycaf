resource "hcloud_load_balancer_network" "main" {
  load_balancer_id        = local.load_balancer_id
  network_id              = try(local.network_id, null)
  subnet_id               = try(local.subnet_id, null)
  ip                      = try(var.settings.ip, null)
  enable_public_interface = try(var.settings.enable_public_interface, true)
}
