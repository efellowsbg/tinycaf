resource "azurerm_virtual_network_gateway_connection" "main" {
  name                = var.settings.name
  location            = local.location
  resource_group_name = local.resource_group_name
  dpd_timeout_seconds = try(var.settings.dpd_timeout_seconds, null)
  tags                = local.tags

  virtual_network_gateway_id         = local.virtual_network_gateway_id
  local_network_gateway_id           = local.local_network_gateway_id
  ingress_nat_rule_ids               = try(var.settings.ingress_nat_rule_ids, [])
  enable_bgp                         = try(var.settings.enable_bgp, false)
  type                               = try(var.settings.type, "IPsec")
  routing_weight                     = try(var.settings.routing_weight, null)
  connection_protocol                = try(var.settings.connection_protocol, "IKEv2")
  use_policy_based_traffic_selectors = try(var.settings.use_policy_based_traffic_selectors, true)

  shared_key = try(var.settings.shared_key, null) != null ? var.settings.shared_key : (
    try(var.settings.shared_key_secret, null) != null && length(data.azurerm_key_vault_secret.main) > 0
    ? data.azurerm_key_vault_secret.main[0].value
    : null
  )

  dynamic "traffic_selector_policy" {
    for_each = try(var.settings.selectors, {})

    content {
      local_address_cidrs  = try(traffic_selector_policy.value.local_address_cidrs, null)
      remote_address_cidrs = try(traffic_selector_policy.value.remote_address_cidrs, null)
    }
  }

  dynamic "ipsec_policy" {
    for_each = can(var.settings.ipsec_policy) ? [1] : []

    content {
      dh_group         = try(var.settings.ipsec_policy.dh_group, "DHGroup14")
      ike_encryption   = try(var.settings.ipsec_policy.ike_encryption, "AES256")
      ike_integrity    = try(var.settings.ipsec_policy.ike_integrity, "SHA256")
      ipsec_encryption = try(var.settings.ipsec_policy.ipsec_encryption, "AES256")
      ipsec_integrity  = try(var.settings.ipsec_policy.ipsec_integrity, "SHA256")
      pfs_group        = try(var.settings.ipsec_policy.pfs_group, "PFS2048")
      sa_lifetime      = try(var.settings.ipsec_policy.sa_lifetime, "28800")
      sa_datasize      = try(var.settings.ipsec_policy.sa_datasize, "102400000")
    }
  }
}
