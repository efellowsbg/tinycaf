resource "hcloud_snapshot" "main" {
  server_id   = local.server_id
  description = try(var.settings.description, null)
  labels      = local.labels
}
