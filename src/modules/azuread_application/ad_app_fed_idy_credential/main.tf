resource "azuread_application_federated_identity_credential" "main" {
  application_id = var.application_id
  audiences      = var.settings.create_fed_credentials.audiences
  issuer         = var.settings.create_fed_credentials.issuer
  subject        = var.settings.create_fed_credentials.subject
  display_name   = try(var.settings.create_fed_credentials.display_name, "fed-cred-${var.application_name}")
  description    = try(var.settings.create_fed_credentials.description, null)
}
