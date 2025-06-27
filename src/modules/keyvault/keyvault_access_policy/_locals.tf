locals {
  all_secret_permissions = [
    "Backup",
    "Delete",
    "Get",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Set",
  ]

  all_key_permissions = [
    "Backup",
    "Create",
    "Decrypt",
    "Delete",
    "Encrypt",
    "Get",
    "Import",
    "List",
    "Purge",
    "Recover",
    "Restore",
    "Sign",
    "UnwrapKey",
    "Update",
    "Verify",
    "WrapKey",
    "Release",
    "Rotate",
    "GetRotationPolicy",
    "SetRotationPolicy",
  ]
  all_certificate_permissions = [
    "Backup", "Create", "Delete", "DeleteIssuers", "Get", "GetIssuers", "Import",
    "List", "ManageContacts", "ManageIssuers", "Purge", "Recover", "Restore",
    "SetIssuers", "Update",
  ]

  debug_settings    = var.settings
  has_logged_in_key = contains(keys(var.settings), "managed_identity")
}


locals {
  normalized_access_policies = flatten([
    for policy_key, policy in var.access_policies : concat(
      [
        for ref in try(policy.managed_identity_refs, []) : {
          key                     = "${policy_key}_managed_identity_${ref}"
          object_id               = var.resources[
                                      try(var.settings.managed_identity_lz_key, var.client_config.landingzone_key)
                                    ].managed_identities[ref].principal_id
          key_permissions         = try(policy.key_permissions, [])
          secret_permissions      = try(policy.secret_permissions, [])
          certificate_permissions = try(policy.certificate_permissions, [])
          storage_permissions     = try(policy.storage_permissions, [])
        }
      ],
      [
        for obj_id in try(policy.object_ids, []) : {
          key                     = "${policy_key}_object_id_${obj_id}"
          object_id               = obj_id
          key_permissions         = try(policy.key_permissions, [])
          secret_permissions      = try(policy.secret_permissions, [])
          certificate_permissions = try(policy.certificate_permissions, [])
          storage_permissions     = try(policy.storage_permissions, [])
        }
      ]
    )
  ])
}
