resource "hcloud_floating_ip" "main" {
  type = var.settings.type

  name          = try(var.settings.name, null)
  description   = try(var.settings.description, null)
  home_location = try(var.settings.home_location, null)

  labels = local.labels

  delete_protection = try(var.settings.delete_protection, false)
}
