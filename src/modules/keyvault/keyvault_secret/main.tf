
module "keyvault" {
  source = "../keyvault"
}



resource "azurerm_key_vault_secret" "main" {
  for_each = {
    for key, value in try(var.settings.secrets, {}) :
    key => value
  }
  name         = each.value.name
  value        = each.value.value
  key_vault_id = module.keyvault.id

  lifecycle {
    ignore_changes = [value]
  }
}
