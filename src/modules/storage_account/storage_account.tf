resource "azurerm_storage_account" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags

  account_kind             = try(var.settings.account_kind, "StorageV2")
  account_tier             = try(var.settings.account_tier, "Standard")
  account_replication_type = var.settings.account_replication_type

  allow_nested_items_to_be_public   = try(var.settings.allow_nested_items_to_be_public, null)
  cross_tenant_replication_enabled  = try(var.settings.cross_tenant_replication_enabled, null)
  large_file_share_enabled          = try(var.settings.large_file_share_enabled, null)
  infrastructure_encryption_enabled = try(var.settings.infrastructure_encryption_enabled, null)
  is_hns_enabled                    = try(var.settings.is_hns_enabled, null)
  sftp_enabled                      = try(var.settings.sftp_enabled, null)
  nfsv3_enabled                     = try(var.settings.nfsv3_enabled, null)

  dynamic "network_rules" {
    for_each = can(var.settings.network_rules) ? [1] : []

    content {
      default_action             = try(var.settings.network_rules.default_action, "Deny")
      bypass                     = try(var.settings.network_rules.bypass, null)
      ip_rules                   = try(var.settings.network_rules.allowed_ips, null)
      virtual_network_subnet_ids = try(local.subnet_ids, null)

      dynamic "private_link_access" {
        for_each = can(var.settings.network_rules.private_link_access) ? [1] : []

        content {
          endpoint_resource_id = var.settings.network_rules.private_link_access.endpoint_resource_id
          endpoint_tenant_id   = try(var.settings.network_rules.private_link_access.endpoint_tenant_id, null)
        }
      }
    }
  }

  dynamic "identity" {
    for_each = can(var.settings.identity) ? [1] : []

    content {
      type         = try(var.settings.identity.type, null)
      identity_ids = try(local.identity_ids, null)
    }
  }

  dynamic "blob_properties" {
    for_each = can(var.settings.blob_properties) ? [1] : []

    content {
      versioning_enabled = try(var.settings.blob_properties.versioning_enabled,false)
      dynamic "cors_rule" {
        for_each = can(var.settings.blob_properties.cors_rule) ? [1] : []

        content {
          allowed_headers    = var.settings.blob_properties.cors_rule.allowed_headers
          allowed_methods    = var.settings.blob_properties.cors_rule.allowed_methods
          allowed_origins    = var.settings.blob_properties.cors_rule.allowed_origins
          exposed_headers    = var.settings.blob_properties.cors_rule.exposed_headers
          max_age_in_seconds = var.settings.blob_properties.cors_rule.max_age_in_seconds
        }
      }

      dynamic "delete_retention_policy" {
        for_each = can(var.settings.blob_properties.delete_retention_policy) ? [1] : []

        content {
          days                     = try(var.settings.blob_properties.delete_retention_policy.days, null)
          permanent_delete_enabled = try(var.settings.blob_properties.delete_retention_policy.permanent_delete_enabled, null)
        }
      }

      dynamic "restore_policy" {
        for_each = can(var.settings.blob_properties.restore_policy) ? [1] : []

        content {
          days = var.settings.blob_properties.restore_policy.days
        }
      }
    }
  }

  dynamic "share_properties" {
    for_each = can(var.settings.share_properties) ? [1] : []

    content {
      dynamic "cors_rule" {
        for_each = can(var.settings.share_properties.cors_rule) ? [1] : []

        content {
          allowed_headers    = var.settings.share_properties.cors_rule.allowed_headers
          allowed_methods    = var.settings.share_properties.cors_rule.allowed_methods
          allowed_origins    = var.settings.share_properties.cors_rule.allowed_origins
          exposed_headers    = var.settings.share_properties.cors_rule.exposed_headers
          max_age_in_seconds = var.settings.share_properties.cors_rule.max_age_in_seconds
        }
      }

      dynamic "retention_policy" {
        for_each = can(var.settings.share_properties.retention_policy) ? [1] : []

        content {
          days = try(var.settings.share_properties.retention_policy.days, null)
        }
      }

      dynamic "smb" {
        for_each = can(var.settings.share_properties.smb) ? [1] : []

        content {
          versions                        = try(var.settings.share_properties.smb.versions, null)
          authentication_types            = try(var.settings.share_properties.smb.authentication_types, null)
          kerberos_ticket_encryption_type = try(var.settings.share_properties.smb.kerberos_ticket_encryption_type, null)
          channel_encryption_type         = try(var.settings.share_properties.smb.channel_encryption_type, null)
          multichannel_enabled            = try(var.settings.share_properties.smb.multichannel_enabled, null)
        }
      }
    }
  }

  dynamic "azure_files_authentication" {
    for_each = can(var.settings.azure_files_authentication) ? [1] : []

    content {
      directory_type                 = var.settings.azure_files_authentication.directory_type
      default_share_level_permission = try(var.settings.azure_files_authentication.default_share_level_permission, null)

      dynamic "active_directory" {
        for_each = can(var.settings.azure_files_authentication.active_directory) ? [1] : []

        content {
          domain_name         = var.settings.azure_files_authentication.active_directory.domain_name
          domain_guid         = var.settings.azure_files_authentication.active_directory.domain_guid
          domain_sid          = try(var.settings.azure_files_authentication.active_directory.domain_sid, null)
          storage_sid         = try(var.settings.azure_files_authentication.active_directory.storage_sid, null)
          forest_name         = try(var.settings.azure_files_authentication.active_directory.forest_name, null)
          netbios_domain_name = try(var.settings.azure_files_authentication.active_directory.netbios_domain_name, null)
        }
      }
    }
  }

  dynamic "routing" {
    for_each = can(var.settings.routing) ? [1] : []

    content {
      publish_internet_endpoints  = try(var.settings.routing.publish_internet_endpoints, null)
      publish_microsoft_endpoints = try(var.settings.routing.publish_microsoft_endpoints, null)
      choice                      = try(var.settings.routing.choice, null)
    }
  }

  dynamic "sas_policy" {
    for_each = try(var.settings.sas_policy, {})

    content {
      expiration_period = sas_policy.value.expiration_period
      expiration_action = try(sas_policy.value.expiration_action, null)
    }
  }
}
