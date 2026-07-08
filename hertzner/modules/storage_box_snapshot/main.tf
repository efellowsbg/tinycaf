resource "hcloud_storage_box_snapshot" "main" {
  storage_box_id = local.storage_box_id
  description    = try(var.settings.description, null)
  labels         = local.labels
}
