locals {
  lz_key = try(var.settings.lz_key, var.client_config.landingzone_key)

  resource_group      = var.resources[local.lz_key].resource_groups[var.settings.resource_group_ref]
  resource_group_name = local.resource_group.name
  location            = local.resource_group.location

  automation_account_name = var.resources[
    try(var.settings.acc_lz_key, local.lz_key)
  ].automation_accounts[var.settings.acc_ref].name

  vm = var.resources[
    try(var.settings.vm_lz_key, local.lz_key)
  ].virtual_machines_default[var.vm_key]

  vm_rg_name = var.resources[
    try(var.settings.vm_rg_lz_key, local.lz_key)
  ].resource_groups[var.settings.vm_rg_ref].name

  mi_client_id = var.resources[
    try(var.settings.mi_lz_key, local.lz_key)
  ].managed_identities[var.settings.mi_ref].client_id

  tags = merge(
    var.global_settings.tags,
    var.global_settings.inherit_resource_group_tags ? local.resource_group.tags : {},
    try(var.settings.tags, {})
  )

  job_parameters = {
    rg_name         = local.vm_rg_name
    vm_name         = local.vm.name
    subscription_id = var.global_settings.subscription_id
    mi_client_id    = local.mi_client_id
  }

  start_content = <<-PS
    param(
        [string]$rg_name,
        [string]$vm_name,
        [string]$subscription_id,
        [string]$mi_client_id
    )

    Write-Output "======================================== INFO ========================================"
    Write-Output "Starting VM: $vm_name in SUB: $subscription_id RG: $rg_name"
    Write-Output "======================================================================================"

    Connect-AzAccount -Identity -AccountId $mi_client_id
    Set-AzContext -SubscriptionId $subscription_id

    $vm = Get-AzVM -ResourceGroupName $rg_name -Name $vm_name -Status
    $status = $vm.Statuses[-1].Code

    if ($status -eq "PowerState/running") {
        Write-Warning "VM is already running. No action taken."
    } else {
        Start-AzVM -ResourceGroupName $rg_name -Name $vm_name
        Write-Output "===================================== RESULT ========================================="
        Write-Output "VM: $vm_name STARTED successfully."
        Write-Output "======================================================================================"
    }
  PS

  stop_content = <<-PS
    param(
        [string]$rg_name,
        [string]$vm_name,
        [string]$subscription_id,
        [string]$mi_client_id
    )

    Write-Output "======================================== INFO ========================================"
    Write-Output "Stopping VM: $vm_name in SUB: $subscription_id RG: $rg_name"
    Write-Output "======================================================================================"

    Connect-AzAccount -Identity -AccountId $mi_client_id
    Set-AzContext -SubscriptionId $subscription_id

    $vm = Get-AzVM -ResourceGroupName $rg_name -Name $vm_name -Status
    $status = $vm.Statuses[-1].Code

    if ($status -eq "PowerState/deallocated") {
        Write-Warning "VM is already stopped. No action taken."
    } else {
        Stop-AzVM -ResourceGroupName $rg_name -Name $vm_name -Force
        Write-Output "===================================== RESULT ========================================="
        Write-Output "VM: $vm_name STOPPED (deallocated) successfully."
        Write-Output "======================================================================================"
    }
  PS
}
