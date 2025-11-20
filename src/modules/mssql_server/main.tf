resource "azurerm_mssql_server" "main" {
  name                                         = var.settings.name
  version                                      = var.settings.version
  resource_group_name                          = local.resource_group_name
  location                                     = local.location
  tags                                         = local.tags
  minimum_tls_version                          = try(var.settings.minimum_tls_version, null)
  public_network_access_enabled                = try(var.settings.public_network_access_enabled, null)
  outbound_network_restriction_enabled         = try(var.settings.outbound_network_restriction_enabled, null)
  connection_policy                            = try(var.settings.connection_policy, null)
  express_vulnerability_assessment_enabled     = try(var.settings.express_vulnerability_assessment_enabled, null)
  primary_user_assigned_identity_id            = local.primary_user_assigned_identity_id
  transparent_data_encryption_key_vault_key_id = local.transparent_data_encryption_key_vault_key_id

  administrator_login          = try(var.settings.administrator_login, "mssql${var.settings.name}admin")
  administrator_login_password = local.administrator_login_password
  # administrator_login_password_wo         = try(var.settings.administrator_login_password_wo, null)
  # administrator_login_password_wo_version = try(var.settings.administrator_login_password_wo_version, null)


  dynamic "identity" {
    for_each = can(var.settings.identity) ? [1] : []

    content {
      type         = var.settings.identity.type
      identity_ids = try(local.identity_ids, null)
    }
  }

  dynamic "azuread_administrator" {
    for_each = can(var.settings.azuread_administrator) ? [1] : []

    content {
      login_username = try(
        var.resources[
          try(var.settings.azuread_administrator.aad_mi_lz_key, var.client_config.landingzone_key)
        ].managed_identities[var.settings.azuread_administrator.mi_ref].name,
        var.settings.azuread_administrator.login_username
      )
      object_id = try(
        var.resources[
          try(var.settings.azuread_administrator.aad_mi_lz_key, var.client_config.landingzone_key)
        ].managed_identities[var.settings.azuread_administrator.mi_ref].principal_id,
        var.settings.azuread_administrator.object_id
      )
      tenant_id                   = try(var.settings.azuread_administrator.tenant_id, null)
      azuread_authentication_only = try(var.settings.azuread_administrator.azuread_authentication_only, null)
    }
  }

  dynamic "timeouts" {
    for_each = can(var.settings.timeouts) ? [1] : []

    content {
      create = try(var.settings.timeouts.create, null)
      update = try(var.settings.timeouts.update, null)
      read   = try(var.settings.timeouts.read, null)
      delete = try(var.settings.timeouts.delete, null)
    }
  }
}

resource "random_password" "admin" {
  count            = try(length(trimspace(var.settings.key_vault_ref)) > 0, false) ? 1 : 0
  length           = try(var.settings.password_settings.length, 123)
  min_upper        = try(var.settings.password_settings.min_upper, 2)
  min_lower        = try(var.settings.password_settings.min_lower, 2)
  min_special      = try(var.settings.password_settings.min_special, 2)
  numeric          = try(var.settings.password_settings.numeric, true)
  special          = try(var.settings.password_settings.special, true)
  override_special = try(var.settings.password_settings.override_special, "!@#$%&")
}

resource "azurerm_key_vault_secret" "admin_password" {
  count        = try(length(trimspace(var.settings.key_vault_ref)) > 0, false) ? 1 : 0
  name         = try(var.settings.custom_secret_name, "${var.settings.name}-${var.settings.administrator_login}")
  value        = random_password.admin[0].result
  key_vault_id = local.key_vault_id
}
