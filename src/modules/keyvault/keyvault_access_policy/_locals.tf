locals {
  all_key_permissions = [
    "Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import",
    "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update",
    "Verify", "WrapKey", "Release", "Rotate", "GetRotationPolicy", "SetRotationPolicy"
  ]

  all_secret_permissions = [
    "Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"
  ]

  all_certificate_permissions = [
    "Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import",
    "List", "ListIssuers", "ManageContacts", "ManageIssuers", "Purge",
    "Recover", "Restore", "SetIssuers", "Update"
  ]

  all_storage_permissions = [
    "Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS",
    "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update"
  ]

  key_permissions         = contains(try(var.access_policies.key_permissions, []), "All") ? local.all_key_permissions : try(var.access_policies.key_permissions, [])
  secret_permissions      = contains(try(var.access_policies.secret_permissions, []), "All") ? local.all_secret_permissions : try(var.access_policies.secret_permissions, [])
  certificate_permissions = contains(try(var.access_policies.certificate_permissions, []), "All") ? local.all_certificate_permissions : try(var.access_policies.certificate_permissions, [])
  storage_permissions     = contains(try(var.access_policies.storage_permissions, []), "All") ? local.all_storage_permissions : try(var.access_policies.storage_permissions, [])

  normalized_access_policies = flatten([
    concat(
      [
        for ref in try(var.access_policies.managed_identity_refs, []) : {
          key = "${var.policy_name}_managed_identity_${ref}"
          object_id = var.resources[
            try(var.access_policies.managed_identity_lz_key, var.client_config.landingzone_key)
          ].managed_identities[ref].principal_id
          key_permissions         = local.key_permissions
          secret_permissions      = local.secret_permissions
          certificate_permissions = local.certificate_permissions
          storage_permissions     = local.storage_permissions
        }
      ],
      [
        for obj_id in try(var.access_policies.object_ids, []) : {
          key                     = "${var.policy_name}_object_id_${obj_id}"
          object_id               = obj_id
          key_permissions         = local.key_permissions
          secret_permissions      = local.secret_permissions
          certificate_permissions = local.certificate_permissions
          storage_permissions     = local.storage_permissions
        }
      ],
      [
        for ref in try(var.access_policies.azuread_application_refs, []) : {
          key = "${var.policy_name}_azuread_application_${ref}"
          object_id = var.resources[
            try(var.access_policies.azuread_application_lz_key, var.client_config.landingzone_key)
          ].azuread_applications[ref].principal_id
          key_permissions         = local.key_permissions
          secret_permissions      = local.secret_permissions
          certificate_permissions = local.certificate_permissions
          storage_permissions     = local.storage_permissions
        }
      ],
      [
        for upn, u in data.azuread_user.kv_policy_users : {
          key                     = "${var.policy_name}_aad_user_${replace(replace(upn, "@", "_"), ".", "_")}"
          object_id               = u.object_id
          key_permissions         = local.key_permissions
          secret_permissions      = local.secret_permissions
          certificate_permissions = local.certificate_permissions
          storage_permissions     = local.storage_permissions
        }
      ],
      [
        for include in [true] : {
          key                     = "${var.policy_name}_logged_in_user"
          object_id               = var.global_settings.object_id
          key_permissions         = local.key_permissions
          secret_permissions      = local.secret_permissions
          certificate_permissions = local.certificate_permissions
          storage_permissions     = local.storage_permissions
        } if try(var.access_policies.logged_in_user, false)
      ]
    )
  ])
}
