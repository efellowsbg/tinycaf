resource "azurerm_virtual_network" "main" {
  name                = var.settings.name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = var.settings.cidr
  tags                = local.tags

  dynamic "ddos_protection_plan" {
    for_each = var.ddos_id != "" || can(var.global_settings["ddos_protection_plan_id"]) ? [1] : []

    content {
      id     = var.ddos_id != "" ? var.ddos_id : var.global_settings["ddos_protection_plan_id"]
      enable = try(var.settings.ddos_plan, true)
    }
  }

}
