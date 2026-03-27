resource "azurerm_automation_python3_package" "main" {
  for_each = try(var.settings.python_packages, {})

  name                    = try(each.value.name, each.key)
  resource_group_name     = try(local.resource_group_name, var.settings.resource_group_name)
  automation_account_name = azurerm_automation_account.main.name
  content_uri             = try(each.value.content_uri, null)
  content_version         = try(each.value.content_version, null)
  hash_algorithm          = try(each.value.hash_algorithm, null)
  hash_value              = try(each.value.hash_value, null)
  tags                    = try(each.value.tags, local.tags)
}
