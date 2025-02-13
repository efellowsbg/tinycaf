resource "azuread_service_principal" "main" {
  client_id = local.client_id

  # Tags conflicts with feature_tags block, so comment or uncomment respectively
  tags = try(toset([for k, v in local.tags : "${k}=${v}"]), null)

  owners                        = try(toset(var.settings.owners), [var.global_settings.object_id])
  app_role_assignment_required  = try(var.settings.app_role_assignment_required, null)
  account_enabled               = try(var.settings.account_enabled, null)
  alternative_names             = try(var.settings.alternative_names, null)
  description                   = try(var.settings.description, null)
  login_url                     = try(var.settings.login_url, null)
  notes                         = try(var.settings.notes, null)
  notification_email_addresses  = try(var.settings.notification_email_addresses, null)
  preferred_single_sign_on_mode = try(var.settings.preferred_single_sign_on_mode, null)
  use_existing                  = try(var.settings.use_existing, null)

  dynamic "feature_tags" {
    for_each = can(var.settings.feature_tags) && (try(var.settings.tags, null) == null) ? [1] : []

    content {
      custom_single_sign_on = try(var.settings.feature_tags.custom_single_sign_on, null)
      enterprise            = try(var.settings.feature_tags.enterprise, null)
      gallery               = try(var.settings.feature_tags.gallery, null)
      hide                  = try(var.settings.feature_tags.hide, null)
    }
  }

  dynamic "saml_single_sign_on" {
    for_each = can(var.settings.saml_single_sign_on) ? [1] : []

    content {
      relay_state = try(var.settings.saml_single_sign_on, null)
    }
  }
}
