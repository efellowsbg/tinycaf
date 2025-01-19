resource "azurerm_role_assignment" "keyvault_roles" {
  for_each = tomap(flatten([
    for role, kv_refs in try(var.settings.keyvaults, {}) : [
      for kv_ref, kv_data in try(kv_refs, {}) : [
        for identity in try(kv_data.managed_identity_refs, []) : {
          role_definition_name = role
          scope_resource_key   = kv_ref
          principal_id         = identity
        }
      ]
    ]
  ]))

  scope                = try(var.resources.keyvaults[each.value.scope_resource_key].id, null)
  role_definition_name = each.value.role_definition_name
  principal_id         = try(var.resources.managed_identities[each.value.principal_id].id, null)
}
