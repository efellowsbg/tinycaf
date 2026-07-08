resource "hcloud_uploaded_certificate" "main" {
  name        = var.settings.name
  private_key = var.settings.private_key
  certificate = var.settings.certificate
  labels      = local.labels
}
