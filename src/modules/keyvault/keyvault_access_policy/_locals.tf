locals {
  normalized_access_policies = flatten([
    concat(
      [
        for ref in try(var.access_policies.managed_identity_refs, []) : {
          key = "${var.policy_name}_managed_identity_${ref}"
          object_id = var.resources[
            try(var.settings.managed_identity_lz_key, var.client_config.landingzone_key)
          ].managed_identities[ref].principal_id
          key_permissions         = try(var.access_policies.key_permissions, [])
          secret_permissions      = try(var.access_policies.secret_permissions, [])
          certificate_permissions = try(var.access_policies.certificate_permissions, [])
          storage_permissions     = try(var.access_policies.storage_permissions, [])
        }
      ],
      [
        for obj_id in try(var.access_policies.object_ids, []) : {
          key                     = "${var.policy_name}_object_id_${obj_id}"
          object_id               = obj_id
          key_permissions         = try(var.access_policies.key_permissions, [])
          secret_permissions      = try(var.access_policies.secret_permissions, [])
          certificate_permissions = try(var.access_policies.certificate_permissions, [])
          storage_permissions     = try(var.access_policies.storage_permissions, [])
        }
      ]
    )
  ])
}
