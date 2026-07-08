resource "hcloud_floating_ip_assignment" "main" {
  floating_ip_id = local.floating_ip_id
  server_id      = local.server_id
}
