resource "azurerm_storage_account" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags

  account_kind             = try(var.settings.account_kind, "StorageV2")
  account_tier             = try(var.settings.account_tier, "Standard")
  account_replication_type = var.settings.account_replication_type
  allow_nested_items_to_be_public = try(var.settings.allow_nested_items_to_be_public, null)

  cross_tenant_replication_enabled  = try(var.settings.cross_tenant_replication_enabled, false)
  large_file_share_enabled          = try(var.settings.large_file_share_enabled, null)
  infrastructure_encryption_enabled = try(var.settings.infrastructure_encryption_enabled, null)

  is_hns_enabled = try(var.settings.is_hns_enabled, null)
  sftp_enabled   = try(var.settings.sftp_enabled, null)
  nfsv3_enabled  = try(var.settings.nfsv3_enabled, null)

  # TODO: identity block
  # TODO: blob properties block
  # TODO: share_properties
  # TODO: azure_files_authentication block
  # TODO: routing block
  # TODO: sas_policy block

  network_rules {
    default_action             = try(var.settings.network_rules.default_action, "Deny")
    bypass                     = try(var.settings.network_rules.bypass, null)
    ip_rules                   = try(var.settings.network_rules.allowed_ips, null)
    virtual_network_subnet_ids = local.subnet_ids
  }
}
