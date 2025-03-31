resource "azurerm_backup_protected_vm" "backup" {
  count = try(var.settings.backup, null) == null ? 0 : 1

  resource_group_name = can(var.settings.backup.backup_vault_rg) ? var.settings.backup.backup_vault_rg : var.resources.recovery_vaults[var.settings.backup.vault_key].resource_group_name
  recovery_vault_name = can(var.settings.backup.backup_vault_name) ? var.settings.backup.backup_vault_name : var.resources.recovery_vaults[var.settings.backup.vault_key].name
  backup_policy_id    = can(var.settings.backup.backup_policy_id) ? var.settings.backup.backup_policy_id : var.resources.recovery_vaults[var.settings.backup.vault_key].backup_policies.virtual_machines[var.settings.backup.policy_key].id

  source_vm_id = try(azurerm_linux_virtual_machine.main.id, null)
}
