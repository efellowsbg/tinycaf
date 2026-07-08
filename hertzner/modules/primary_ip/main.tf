resource "hcloud_primary_ip" "main" {
  name          = var.settings.name
  type          = var.settings.type
  assignee_type = try(var.settings.assignee_type, "server")
  auto_delete   = try(var.settings.auto_delete, false)

  datacenter = try(var.settings.datacenter, null)
  location   = try(var.settings.location, null)

  labels = local.labels

  delete_protection = try(var.settings.delete_protection, false)
}
