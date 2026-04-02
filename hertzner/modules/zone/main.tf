resource "hcloud_zone" "main" {
  name = var.settings.name
  mode = var.settings.mode
  ttl  = try(var.settings.ttl, null)

  labels = local.labels

  delete_protection = try(var.settings.delete_protection, false)

  dynamic "primary_nameservers" {
    for_each = try(var.settings.primary_nameservers, {})
    content {
      address        = primary_nameservers.value.address
      port           = try(primary_nameservers.value.port, null)
      tsig_algorithm = try(primary_nameservers.value.tsig_algorithm, null)
      tsig_key       = try(primary_nameservers.value.tsig_key, null)
    }
  }
}
