resource "hcloud_server_network" "main" {
  server_id  = local.server_id
  network_id = try(local.network_id, null)
  subnet_id  = try(local.subnet_id, null)
  ip         = try(var.settings.ip, null)
  alias_ips  = try(var.settings.alias_ips, null)
}
