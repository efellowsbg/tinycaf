resource "hcloud_managed_certificate" "main" {
  name         = var.settings.name
  domain_names = var.settings.domain_names
  labels       = local.labels
}
