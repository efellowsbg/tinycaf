resource "azuread_application" "main" {
  display_name = var.settings.display_name

  owners                         = try(toset(var.settings.owners), [var.global_settings.object_id])
  identifier_uris                = try(var.settings.identifier_uris, null)
  logo_image                     = try(filebase64(var.settings.logo_image), null)
  sign_in_audience               = try(var.settings.sign_in_audience, null)
  description                    = try(var.settings.description, null)
  device_only_auth_enabled       = try(var.settings.device_only_auth_enabled, null)
  fallback_public_client_enabled = try(var.settings.fallback_public_client_enabled, null)
  group_membership_claims        = try(var.settings.group_membership_claims, null)
  marketing_url                  = try(var.settings.marketing_url, null)
  notes                          = try(var.settings.notes, null)
  oauth2_post_response_required  = try(var.settings.oauth2_post_response_required, null)
  prevent_duplicate_names        = try(var.settings.prevent_duplicate_names, null)
  privacy_statement_url          = try(var.settings.privacy_statement_url, null)
  service_management_reference   = try(var.settings.service_management_reference, null)
  template_id                    = try(var.settings.template_id, null)
  terms_of_service_url           = try(var.settings.terms_of_service_url, null)
  tags                           = try(local.tags, null)

  dynamic "api" {
    for_each = can(var.settings.api) ? [1] : []

    content {
      known_client_applications      = try(var.settings.api.known_client_applications, null)
      mapped_claims_enabled          = try(var.settings.api.mapped_claims_enabled, null)
      requested_access_token_version = try(var.settings.api.requested_access_token_version, null)

      dynamic "oauth2_permission_scope" {
        for_each = try(var.settings.api.oauth2_permission_scopes, {})

        content {
          id                         = oauth2_permission_scope.value.id
          admin_consent_description  = oauth2_permission_scope.value.admin_consent_description
          admin_consent_display_name = oauth2_permission_scope.value.admin_consent_display_name

          enabled                   = try(oauth2_permission_scope.value.enabled, null)
          type                      = try(oauth2_permission_scope.value.type, null)
          user_consent_description  = try(oauth2_permission_scope.value.user_consent_description, null)
          user_consent_display_name = try(oauth2_permission_scope.value.user_consent_display_name, null)
          value                     = try(oauth2_permission_scope.value.value, null)
        }
      }
    }
  }

  dynamic "password" {
    for_each = can(var.settings.password) ? [1] : []

    content {
      display_name = var.settings.password.display_name
      end_date     = try(var.settings.password.end_date, null)
      start_date   = try(var.settings.password.start_date, null)
    }
  }

  dynamic "feature_tags" {
    for_each = can(var.settings.feature_tags) && var.settings.tags == null ? [1] : []

    content {
      custom_single_sign_on = try(var.settings.feature_tags.custom_single_sign_on, null)
      enterprise            = try(var.settings.feature_tags.enterprise, null)
      gallery               = try(var.settings.feature_tags.gallery, null)
      hide                  = try(var.settings.feature_tags.hide, null)
    }
  }

  dynamic "public_client" {
    for_each = can(var.settings.public_client) ? [1] : []
    content {
      redirect_uris = try(var.settings.public_client.redirect_uris, null)
    }
  }

  dynamic "single_page_application" {
    for_each = can(var.settings.single_page_application) ? [1] : []
    content {
      redirect_uris = try(var.settings.single_page_application.redirect_uris, null)
    }
  }

  dynamic "app_role" {
    for_each = try(var.settings.app_roles, {})

    content {
      id                   = app_role.value.id
      allowed_member_types = app_role.value.allowed_member_types
      description          = app_role.value.description
      display_name         = app_role.value.display_name
      enabled              = try(app_role.value.enabled, null)
      value                = try(app_role.value.value, null)
    }
  }


  dynamic "optional_claims" {
    for_each = can(var.settings.optional_claims) ? [1] : []

    content {
      dynamic "access_token" {
        for_each = try(var.settings.optional_claims.access_tokens, {})

        content {
          name                  = access_token.value.name
          additional_properties = try(access_token.value.additional_properties, null)
          essential             = try(access_token.value.essential, null)
          source                = try(access_token.value.source, null)
        }
      }

      dynamic "id_token" {
        for_each = try(var.settings.optional_claims.id_tokens, {})

        content {
          name                  = id_token.value.name
          additional_properties = try(id_token.value.additional_properties, null)
          essential             = try(id_token.value.essential, null)
          source                = try(id_token.value.source, null)
        }
      }

      dynamic "saml2_token" {
        for_each = try(var.settings.optional_claims.saml2_tokens, {})

        content {
          name                  = saml2_token.value.name
          additional_properties = try(saml2_token.value.additional_properties, null)
          essential             = try(saml2_token.value.essential, null)
          source                = try(saml2_token.value.source, null)
        }
      }
    }
  }

  dynamic "required_resource_access" {
    for_each = try(var.settings.required_resource_access, {})

    content {
      resource_app_id = required_resource_access.value.resource_app_id

      dynamic "resource_access" {
        for_each = required_resource_access.value.resource_access

        content {
          id   = resource_access.value.id
          type = resource_access.value.type
        }
      }
    }
  }

  dynamic "web" {
    for_each = can(var.settings.web) ? [1] : []

    content {
      homepage_url  = try(var.settings.web.homepage_url, null)
      logout_url    = try(var.settings.web.logout_url, null)
      redirect_uris = try(var.settings.web.redirect_uris, null)

      dynamic "implicit_grant" {
        for_each = can(var.settings.web.implicit_grant) ? [1] : []

        content {
          access_token_issuance_enabled = try(var.settings.web.implicit_grant.access_token_issuance_enabled, null)
          id_token_issuance_enabled     = try(var.settings.web.implicit_grant.id_token_issuance_enabled, null)
        }
      }
    }
  }

  dynamic "timeouts" {
    for_each = can(var.settings.timeouts) ? [1] : []

    content {
      read   = try(var.settings.timeouts.read, null)
      create = try(var.settings.timeouts.create, null)
      update = try(var.settings.timeouts.update, null)
      delete = try(var.settings.timeouts.delete, null)
    }
  }
}
