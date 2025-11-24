output "resource_groups" {
  value = module.resource_groups
}

output "managed_identities" {
  value = module.managed_identities
}

output "virtual_networks" {
  value = module.virtual_networks
}

output "subscription_assignments" {
  value = module.subscription_assignments
}

# output "subnets" {
#   value = {
#     for vnet_key, vnet in module.virtual_networks :
#     vnet_key => vnet.subnets
#   }
# }

output "vnet_peerings" {
  value = module.vnet_peerings
}

output "public_ips" {
  value = module.public_ips
}

output "local_network_gateways" {
  value = module.local_network_gateways
}

output "virtual_network_gateways" {
  value = module.virtual_network_gateways
}

output "keyvaults" {
  value = module.keyvaults
}

output "key_vault_keys" {
  value = module.key_vault_keys
}

output "private_dns_zones" {
  value = module.private_dns_zones
}

output "virtual_network_gateway_connections" {
  value = module.virtual_network_gateway_connections
}

output "kubernetes_clusters" {
  value = module.kubernetes_clusters
}

output "role_assignments" {
  value = module.role_assignments
}

output "managed_disks" {
  value = module.managed_disks
}

output "storage_accounts" {
  value     = module.storage_accounts
  sensitive = true
}

output "recovery_vaults" {
  value = module.recovery_vaults
}

output "disk_encryption_sets" {
  value = module.disk_encryption_sets
}

output "virtual_machines" {
  value = module.virtual_machines
}

output "postgres" {
  value = module.postgres
}

output "postgresql_flexible_servers" {
  value = module.postgres
}

output "container_registries" {
  value = module.container_registries
}

output "mssql_servers" {
  value = module.mssql_servers
}

output "function_apps" {
  value = module.function_apps
}

output "app_service_plans" {
  value = module.app_service_plans
}

output "logic_apps_workflow" {
  value = module.logic_apps_workflow
}

output "private_dns_a_records" {
  value = module.private_dns_a_records
}

output "log_analytics_workspaces" {
  value = module.log_analytics_workspaces
}

output "log_analytics_data_export_rules" {
  value = module.log_analytics_data_export_rules
}

output "nat_gateways" {
  value = module.nat_gateways
}

output "network_security_groups" {
  value = module.network_security_groups
}

output "subnet_network_security_group_associations" {
  value = module.subnet_network_security_group_associations
}

output "private_endpoints" {
  value = module.private_endpoints
}

output "mssql_managed_instances" {
  value = module.mssql_managed_instances
}

output "logic_apps_standard" {
  value = module.logic_apps_standard
}

output "remote_states" {
  value = module.remote_states
}

output "role_definitions" {
  value = module.role_definitions
}

output "azuread_applications" {
  value = module.azuread_applications
}

output "azuread_service_principals" {
  value = module.azuread_service_principals
}

output "route_tables" {
  value = module.route_tables
}

output "waf_policies" {
  value = module.waf_policies
}

output "automation_accounts" {
  value = module.automation_accounts
}

output "dns_zones" {
  value = module.dns_zones
}

output "private_dns_cname_records" {
  value = module.private_dns_cname_records
}

output "azuread_groups" {
  value = module.azuread_groups
}

output "bastion_hosts" {
  value = module.bastion_hosts
}

output "subscriptions" {
  value = module.subscriptions
}

output "automation_runbooks" {
  value = module.automation_runbooks
}

output "azuread_users" {
  value = module.azuread_users
}

output "automation_schedules" {
  value = module.automation_schedules
}

output "automation_jobs_schedules" {
  value = module.automation_jobs_schedules
}

output "azuread_administrative_units" {
  value = module.azuread_administrative_units
}
