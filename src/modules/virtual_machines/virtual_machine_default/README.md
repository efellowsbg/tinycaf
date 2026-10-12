# Legacy VM boot diagnostics

For a VM with `type = "default"`, add the optional block to its settings map:

```hcl
boot_diagnostics = {
  enabled = true
}
```

This uses Azure-managed boot diagnostics storage. Omitting `storage_uri`, or
setting it to null or an empty string, selects managed storage. For a custom
storage account, set `storage_uri` to its blob endpoint and configure the
necessary storage permissions and network access separately.

An omitted or null `boot_diagnostics` block preserves the module's previous
behaviour. A present block defaults `enabled` to true. Setting `enabled = false`
explicitly disables collection. The legacy AzureRM resource requires a
`storage_uri` argument; the module supplies an empty string for managed storage.

Enabling diagnostics does not install guest software, prepare NVMe drivers or
change the VM's disk controller. It collects boot screenshots and serial output.
Review the Terraform plan for an existing VM before applying.

References:
- [Azure boot diagnostics](https://learn.microsoft.com/en-us/azure/virtual-machines/boot-diagnostics)
- [Pinned legacy AzureRM provider implementation](https://github.com/hashicorp/terraform-provider-azurerm/blob/v4.49.0/internal/services/legacy/virtual_machine_resource.go)
