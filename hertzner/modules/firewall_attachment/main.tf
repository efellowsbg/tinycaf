resource "hcloud_firewall_attachment" "main" {
  firewall_id     = local.firewall_id
  server_ids      = try(local.server_ids, null)
  label_selectors = try(var.settings.label_selectors, null)
}
