module "management_policy" {
  source   = "./management_policies"
  for_each = try(var.storage_account.management_policies, {})

  storage_account_id = azurerm_storage_account.main.id
  settings           = each.value
}


