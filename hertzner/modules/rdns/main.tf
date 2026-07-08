resource "hcloud_rdns" "main" {
  dns_ptr    = var.settings.dns_ptr
  ip_address = var.settings.ip_address

  server_id        = try(local.server_id, null)
  primary_ip_id    = try(local.primary_ip_id, null)
  floating_ip_id   = try(local.floating_ip_id, null)
  load_balancer_id = try(local.load_balancer_id, null)
}
