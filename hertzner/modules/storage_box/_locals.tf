locals {
  labels = merge(
    try(var.global_settings.labels, {}),
    try(var.settings.labels, {})
  )
}
