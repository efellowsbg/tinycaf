resource "hcloud_placement_group" "main" {
  name   = var.settings.name
  type   = try(var.settings.type, "spread")
  labels = local.labels
}
