resource "hcloud_load_balancer_target" "main" {
  type             = var.settings.type
  load_balancer_id = local.load_balancer_id

  server_id      = try(local.server_id, null)
  label_selector = try(var.settings.label_selector, null)
  ip             = try(var.settings.ip, null)
  use_private_ip = try(var.settings.use_private_ip, null)
}
