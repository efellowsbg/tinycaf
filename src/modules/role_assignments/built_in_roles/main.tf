resource "azurerm_role_assignment" "main" {
  for_each = var.settings.keyvaults

  scope                = var.resources.keyvaults[each.key].id
  role_definition_name = var.settings.role_definition_name
  principal_id         = var.resources.managed_identities[each.value.managed_identity_refs[0]].id
}
