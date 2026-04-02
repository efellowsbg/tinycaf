output "networks" {
  value = module.networks
}

output "network_subnets" {
  value = module.network_subnets
}

output "network_routes" {
  value = module.network_routes
}

output "servers" {
  value = module.servers
}

output "server_networks" {
  value = module.server_networks
}

output "volumes" {
  value = module.volumes
}

output "volume_attachments" {
  value = module.volume_attachments
}

output "firewalls" {
  value = module.firewalls
}

output "firewall_attachments" {
  value = module.firewall_attachments
}

output "ssh_keys" {
  value = module.ssh_keys
}

output "placement_groups" {
  value = module.placement_groups
}

output "primary_ips" {
  value = module.primary_ips
}

output "rdns_records" {
  value = module.rdns_records
}

output "floating_ips" {
  value = module.floating_ips
}

output "floating_ip_assignments" {
  value = module.floating_ip_assignments
}

output "load_balancers" {
  value = module.load_balancers
}

output "load_balancer_services" {
  value = module.load_balancer_services
}

output "load_balancer_targets" {
  value = module.load_balancer_targets
}

output "load_balancer_networks" {
  value = module.load_balancer_networks
}

output "managed_certificates" {
  value = module.managed_certificates
}

output "uploaded_certificates" {
  value     = module.uploaded_certificates
  sensitive = true
}

output "snapshots" {
  value = module.snapshots
}

output "storage_boxes" {
  value     = module.storage_boxes
  sensitive = true
}

output "storage_box_snapshots" {
  value = module.storage_box_snapshots
}

output "storage_box_subaccounts" {
  value     = module.storage_box_subaccounts
  sensitive = true
}

output "zones" {
  value = module.zones
}

output "zone_records" {
  value = module.zone_records
}

output "zone_rrsets" {
  value = module.zone_rrsets
}
