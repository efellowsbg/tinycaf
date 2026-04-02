resource "hcloud_zone_record" "main" {
  zone    = local.zone_id
  name    = var.settings.name
  type    = var.settings.type
  value   = var.settings.value
  comment = try(var.settings.comment, null)
}
