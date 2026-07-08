resource "hcloud_network" "main" {
  name     = var.settings.name
  ip_range = var.settings.ip_range

  labels = local.labels

  delete_protection       = try(var.settings.delete_protection, false)
  expose_routes_to_vswitch = try(var.settings.expose_routes_to_vswitch, false)
}
