resource "azurerm_marketplace_agreement" "main" {
  count                        = try(var.settings.marketplace_agreement, null) == null ? 0 : 1
  publisher = var.settings.marketplace_agreement.publisher
  offer = var.settings.marketplace_agreement.offer
  plan = var.settings.marketplace_agreement.plan
}
