resource "azurerm_kubernetes_cluster" "main" {
  name                = var.settings.name
  location            = local.location
  resource_group_name = local.resource_group_name
  dns_prefix          = "exampleaks1"
  default_node_pool {
    name       = "default"
    node_count = try(var.settings.default_node_pool.node_count, 1)
    vm_size    = try(var.settings.default_node_pool.vm_size, "Standard_D3_v2")
    type = try(var.settings.default_node_pool.type, "VirtualMachineScaleSets")
    max_pods = try(var.settings.default_node_pool.max_pods, "VirtualMachineScaleSets")
    vnet_subnet_id = local.vnet_subnet_id
  }
  identity {
    type = "SystemAssigned"
  }
  tags = local.tags
}
