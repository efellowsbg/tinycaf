output "start_runbook_ids" {
  value = { for k, v in azurerm_automation_runbook.start : k => v.id }
}

output "stop_runbook_ids" {
  value = { for k, v in azurerm_automation_runbook.stop : k => v.id }
}

output "start_runbook_names" {
  value = { for k, v in azurerm_automation_runbook.start : k => v.name }
}

output "stop_runbook_names" {
  value = { for k, v in azurerm_automation_runbook.stop : k => v.name }
}
