resource "terraform_data" "python_package_dependency" {
  for_each = try(var.settings.python_packages, {})

  input = [
    for package_ref in try(each.value.depends_on_refs, []) :
    azurerm_automation_python3_package.main[package_ref].id
  ]
}

resource "azurerm_automation_python3_package" "main" {
  for_each = try(var.settings.python_packages, {})

  name                    = try(each.value.name, each.key)
  resource_group_name     = try(local.resource_group_name, var.settings.resource_group_name)
  automation_account_name = azurerm_automation_account.main.name
  content_uri             = each.value.content_uri
  content_version         = try(each.value.content_version, each.value.version, null)
  hash_algorithm          = try(each.value.hash_algorithm, null)
  hash_value              = try(each.value.hash_value, null)
  tags                    = try(each.value.tags, local.tags)

  depends_on = [terraform_data.python_package_dependency[each.key]]
}
