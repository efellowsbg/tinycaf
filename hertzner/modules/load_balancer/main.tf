resource "hcloud_load_balancer" "main" {
  name               = var.settings.name
  load_balancer_type = var.settings.load_balancer_type

  location     = try(var.settings.location, null)
  network_zone = try(var.settings.network_zone, null)

  labels = local.labels

  delete_protection = try(var.settings.delete_protection, false)

  dynamic "algorithm" {
    for_each = can(var.settings.algorithm) ? [1] : []
    content {
      type = try(var.settings.algorithm.type, "round_robin")
    }
  }
}
