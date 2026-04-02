resource "hcloud_zone_rrset" "main" {
  zone = local.zone_id
  name = var.settings.name
  type = var.settings.type
  ttl  = try(var.settings.ttl, null)

  labels = local.labels

  change_protection = try(var.settings.change_protection, false)

  dynamic "records" {
    for_each = var.settings.records
    content {
      value   = records.value.value
      comment = try(records.value.comment, null)
    }
  }
}
