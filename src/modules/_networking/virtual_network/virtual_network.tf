resource "azurerm_virtual_network" "main" {
  name                = var.settings.name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = var.settings.cidr
  tags                = local.tags
  for_each = (
    !can(var.settings.ddos) || var.settings.ddos != false
    ) && (
    var.ddos_id != "" || can(var.global_settings.ddos_protection_plan_id)
  ) ? [1] : []

  dynamic "ddos_protection_plan" {
    for_each = (
      (!can(var.settings.ddos) || var.settings.ddos != false) &&
      (var.ddos_id != "" && can(var.global_settings.ddos_protection_plan_id))
    ) ? { "enabled" = true } : {}

    content {
      id     = var.ddos_id != "" ? var.ddos_id : var.global_settings["ddos_protection_plan_id"]
      enable = true
    }
  }
}
