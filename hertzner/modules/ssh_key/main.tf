resource "hcloud_ssh_key" "main" {
  name       = var.settings.name
  public_key = var.settings.public_key
  labels     = local.labels
}
