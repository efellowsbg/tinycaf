resource "azurerm_storage_container" "main" {
  for_each = try(var.settings.containers, {})

  name               = each.value.name
  storage_account_id = azurerm_storage_account.main.id

  container_access_type = try(each.value.access_type, null)
}


resource "azapi_resource" "main" {
  for_each = try(var.settings.api_containers, {})

  type      = "Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01"
  name      = each.value.name
  parent_id = "${azurerm_storage_account.main.id}/blobServices/default"
  body = {
    properties = {
      defaultEncryptionScope      = try(each.value.default_encryption_scope, "$account-encryption-key")
      denyEncryptionScopeOverride = try(each.value.deny_encryption_scope_override, false)
      immutableStorageWithVersioning = {
        enabled = try(each.value.enable_versioning, true)
      }
      publicAccess = try(each.value.public_access, "None")
    }
  }
}


terraform {
  required_providers {
    azapi = {
      source = "Azure/azapi"
    }
  }
}
