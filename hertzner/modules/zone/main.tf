resource "hcloud_zone" "main" {
  name = var.settings.name
  mode = var.settings.mode
  ttl  = try(var.settings.ttl, null)

  labels = local.labels

  delete_protection = try(var.settings.delete_protection, false)

  primary_nameservers = can(var.settings.primary_nameservers) ? [
    for ns in var.settings.primary_nameservers : {
      address        = ns.address
      port           = try(ns.port, null)
      tsig_algorithm = try(ns.tsig_algorithm, null)
      tsig_key       = try(ns.tsig_key, null)
    }
  ] : null
}
