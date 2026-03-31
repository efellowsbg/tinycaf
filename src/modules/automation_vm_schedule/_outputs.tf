output "start_runbook_id" {
  value = try(azurerm_automation_runbook.start[0].id, null)
}

output "stop_runbook_id" {
  value = try(azurerm_automation_runbook.stop[0].id, null)
}

output "start_runbook_name" {
  value = try(azurerm_automation_runbook.start[0].name, null)
}

output "stop_runbook_name" {
  value = try(azurerm_automation_runbook.stop[0].name, null)
}
