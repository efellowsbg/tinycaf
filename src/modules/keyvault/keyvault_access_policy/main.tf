module "logged_in_user" {
  source             = "./access_policy"
  count              = var.policy_name == "logged_in_user" ? 1 : 0
  keyvault_id        = var.keyvault_id
  tenant_id          = var.global_settings.tenant_id
  access_policies    = try(var.access_policies, null)
  object_id          = var.global_settings.object_id

  key_permissions = (
    try(var.access_policies.key_permissions, null) == "All" ?
    local.all_key_permissions :
    try(var.access_policies.key_permissions, [])
  )

  secret_permissions = (
    try(var.access_policies.secret_permissions, null) == "All" ?
    local.all_secret_permissions :
    try(var.access_policies.secret_permissions, [])
  )

  certificate_permissions = (
    try(var.access_policies.certificate_permissions, null) == "All" ?
    local.all_certificate_permissions :
    try(var.access_policies.certificate_permissions, [])
  )
}

module "managed_identities" {
  source   = "./access_policy"
  for_each = var.policy_name == "managed_identity" && length(try(var.access_policies.managed_identity_refs, [])) > 0 ? {
    for idx, ref in try(var.access_policies.managed_identity_refs, []) : idx => ref
  } : {}

  keyvault_id     = var.keyvault_id
  access_policies = var.access_policies
  tenant_id       = var.global_settings.tenant_id

  object_id = var.resources[
    try(var.settings.managed_identity_lz_key, var.client_config.landingzone_key)
  ].managed_identities[each.value].principal_id

  key_permissions = (
    try(var.access_policies.managed_identity.key_permissions, null) == "All" ?
    local.all_key_permissions :
    try(var.access_policies.managed_identity.key_permissions, [])
  )

  secret_permissions = (
    try(var.access_policies.managed_identity.secret_permissions, null) == "All" ?
    local.all_secret_permissions :
    try(var.access_policies.managed_identity.secret_permissions, [])
  )

  certificate_permissions = (
    try(var.access_policies.managed_identity.certificate_permissions, null) == "All" ?
    local.all_certificate_permissions :
    try(var.access_policies.managed_identity.certificate_permissions, [])
  )
}

module "object_ids" {
  source = "./access_policy"

  for_each = var.policy_name == "object_ids" ? {
    for pair in flatten([
      for policy_idx, policy in try(var.access_policies.object_ids, []) : [
        for id_idx, obj_id in policy.object_ids : {
          key = "${policy_idx}-${id_idx}"
          value = {
            object_id               = obj_id
            key_permissions         = try(policy.key_permissions, [])
            secret_permissions      = try(policy.secret_permissions, [])
            certificate_permissions = try(policy.certificate_permissions, [])
          }
        }
      ]
    ]) : pair.key => pair.value
  } : {}

  keyvault_id             = var.keyvault_id
  tenant_id               = var.global_settings.tenant_id
  access_policies         = var.access_policies

  object_id               = each.value.object_id
  key_permissions         = each.value.key_permissions == "All" ? local.all_key_permissions : each.value.key_permissions
  secret_permissions      = each.value.secret_permissions == "All" ? local.all_secret_permissions : each.value.secret_permissions
  certificate_permissions = each.value.certificate_permissions == "All" ? local.all_certificate_permissions : each.value.certificate_permissions
}



