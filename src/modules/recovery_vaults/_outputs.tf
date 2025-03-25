
output "id" {
  # depends_on = [azurerm_resource_group_template_deployment.asr]
  description = "Output the object ID"
  value       = azurerm_recovery_services_vault.asr.id
}

output "resource_group_name" {
  description = "Output the resource group name"
  value       = local.resource_group_name
}

output "soft_delete_enabled" {
  description = "Boolean indicating if soft deleted is enabled on the vault."
  value       = try(var.settings.soft_delete_enabled, true)
}

output "rbac_id" {
  description = "Principal Id of the Vault"
  value       = try(azurerm_recovery_services_vault.asr.identity.0.principal_id, null)
}