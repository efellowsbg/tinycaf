resource "hcloud_server" "main" {
  name        = var.settings.name
  server_type = var.settings.server_type
  image       = try(var.settings.image, null)
  location    = try(var.settings.location, null)

  user_data = try(var.settings.user_data, null)
  ssh_keys  = try(var.settings.ssh_keys, null)

  labels = local.labels

  backups              = try(var.settings.backups, false)
  keep_disk            = try(var.settings.keep_disk, false)
  iso                  = try(var.settings.iso, null)
  rescue               = try(var.settings.rescue, null)
  firewall_ids         = try(local.firewall_ids, null)
  placement_group_id   = try(local.placement_group_id, null)
  delete_protection    = try(var.settings.delete_protection, false)
  rebuild_protection   = try(var.settings.rebuild_protection, false)
  allow_deprecated_images    = try(var.settings.allow_deprecated_images, false)
  shutdown_before_deletion   = try(var.settings.shutdown_before_deletion, false)
  ignore_remote_firewall_ids = try(var.settings.ignore_remote_firewall_ids, false)

  dynamic "public_net" {
    for_each = can(var.settings.public_net) ? [1] : []
    content {
      ipv4_enabled = try(var.settings.public_net.ipv4_enabled, true)
      ipv6_enabled = try(var.settings.public_net.ipv6_enabled, true)
      ipv4         = try(local.public_net_ipv4, null)
      ipv6         = try(local.public_net_ipv6, null)
    }
  }

  dynamic "network" {
    for_each = try(var.settings.networks, {})
    content {
      network_id = var.resources[
        try(network.value.network_lz_key, var.client_config.landingzone_key)
      ].networks[network.value.network_ref].id
      ip        = try(network.value.ip, null)
      alias_ips = try(network.value.alias_ips, null)
    }
  }
}
