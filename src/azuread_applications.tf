module "azuread_applications" {
  source          = "./modules/azuread_application"
  for_each        = var.azuread_applications
  settings        = each.value
  global_settings = local.global_settings

  client_config = {
    landingzone_key = var.landingzone.key
  }

  resources = merge(
    {
      (var.landingzone.key) = {
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
}

module "azuread_application_passwords" {
  source = "./modules/azuread_application/azuread_application_password"
  for_each = {
    for instance, cfg in var.azuread_applications :
    instance => cfg
    if try(cfg.create_client_secret, null) != null
  }
  settings         = each.value
  global_settings  = local.global_settings
  application_id   = module.azuread_applications[each.key].id
  application_name = module.azuread_applications[each.key].display_name

  client_config = {
    landingzone_key = var.landingzone.key
  }

  resources = merge(
    {
      (var.landingzone.key) = {
        keyvaults = module.keyvaults
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
}

locals {
  azuread_application_federated_identity_credentials_primary = {
    for instance, cfg in var.azuread_applications :
    instance => {
      application_key = instance
      settings        = cfg
    }
    if try(cfg.create_fed_credentials, null) != null
  }

  azuread_application_federated_identity_credentials_additional = merge(concat(
    [{}],
    [
      for instance, cfg in var.azuread_applications : {
        for credential_key, credential in try(cfg.create_fed_credentials_additional, {}) :
        "${instance}.${credential_key}" => {
          application_key = instance
          settings = merge(cfg, {
            create_fed_credentials = credential
          })
        }
      }
    ]
  )...)

  azuread_application_federated_identity_credentials = merge(
    local.azuread_application_federated_identity_credentials_primary,
    local.azuread_application_federated_identity_credentials_additional
  )
}

module "ad_app_fed_idy_credentials" {
  source   = "./modules/azuread_application/ad_app_fed_idy_credential"
  for_each = local.azuread_application_federated_identity_credentials

  settings         = each.value.settings
  global_settings  = local.global_settings
  application_id   = module.azuread_applications[each.value.application_key].id
  application_name = module.azuread_applications[each.value.application_key].display_name

  client_config = {
    landingzone_key = var.landingzone.key
  }

  resources = merge(
    {
      (var.landingzone.key) = {
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
}
