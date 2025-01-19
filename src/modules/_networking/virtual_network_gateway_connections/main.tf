resource "azurerm_virtual_network_gateway_connection" "main" {
  name                = var.settings.name
  location            = local.location
  resource_group_name = local.resource_group_name

  type                       = try(var.settings.type, "IPsec")
  virtual_network_gateway_id = local.virtual_network_gateway_id
  local_network_gateway_id   = local.local_network_gateway_id
  connection_protocol        = try(var.settings.connection_protocol, "IKEv2")
  use_policy_based_traffic_selectors = try(var.settings.use_policy_based_traffic_selectors, true)

  shared_key = try(var.settings.shared_key, null) != null ? var.settings.shared_key : (
        try(var.settings.shared_key_secret, null) != null && length(data.azurerm_key_vault_secret.main) > 0
        ? data.azurerm_key_vault_secret.main[0].value
        : null
      )

  dynamic "ipsec_policy" {
    for_each = try(var.settings.use_policy_based_traffic_selectors, true) ? [1] : []
    content {
      dh_group          = try(var.settings.ipsec_policy.dh_group, "DHGroup14")
      ike_encryption    = try(var.settings.ipsec_policy.ike_encryption, "AES256")
      ike_integrity     = try(var.settings.ipsec_policy.ike_integrity, "SHA256")
      ipsec_encryption  = try(var.settings.ipsec_policy.ipsec_encryption, "AES256")
      ipsec_integrity   = try(var.settings.ipsec_policy.ipsec_integrity, "SHA256")
      pfs_group         = try(var.settings.ipsec_policy.pfs_group, "PFS2048")
      sa_lifetime       = try(var.settings.ipsec_policy.sa_lifetime, "28800")
    }
  }
}
