resource "hcloud_firewall" "main" {
  name   = var.settings.name
  labels = local.labels

  dynamic "rule" {
    for_each = try(var.settings.rules, {})
    content {
      direction       = rule.value.direction
      protocol        = rule.value.protocol
      port            = try(rule.value.port, null)
      source_ips      = try(rule.value.source_ips, null)
      destination_ips = try(rule.value.destination_ips, null)
      description     = try(rule.value.description, null)
    }
  }

  dynamic "apply_to" {
    for_each = try(var.settings.apply_to, {})
    content {
      label_selector = try(apply_to.value.label_selector, null)
      server         = try(apply_to.value.server, null)
    }
  }
}
