# azurerm_virtual_machine is feature-frozen and cannot set the disk controller type.
# Switching SCSI <-> NVMe is only possible together with a size change, so both are sent
# in one request here, before azurerm_virtual_machine.main applies the same size.
# Meant for existing VMs only: on create Azure picks the controller from the size.
resource "azapi_update_resource" "disk_controller" {
  count = can(var.settings.disk_controller_type) ? 1 : 0

  type = "Microsoft.Compute/virtualMachines@2024-07-01"
  # Built from the name, as azurerm_virtual_machine.main depends on this resource
  resource_id = "${local.resource_group.id}/providers/Microsoft.Compute/virtualMachines/${var.settings.name}"

  body = {
    properties = {
      hardwareProfile = {
        vmSize = var.settings.size
      }
      storageProfile = {
        diskControllerType = var.settings.disk_controller_type
      }
    }
  }
}

terraform {
  required_providers {
    azapi = {
      source = "Azure/azapi"
    }
  }
}
