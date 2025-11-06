locals {
  tags = merge(
    var.global_settings.tags,
    try(var.settings.tags, {})
  )
}
