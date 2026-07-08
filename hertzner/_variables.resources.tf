variable "networks" { default = {} }

variable "network_subnets" { default = {} }

variable "network_routes" { default = {} }

variable "servers" { default = {} }

variable "server_networks" { default = {} }

variable "volumes" { default = {} }

variable "volume_attachments" { default = {} }

variable "firewalls" { default = {} }

variable "firewall_attachments" { default = {} }

variable "ssh_keys" { default = {} }

variable "placement_groups" { default = {} }

variable "primary_ips" { default = {} }

variable "rdns_records" { default = {} }

variable "floating_ips" { default = {} }

variable "floating_ip_assignments" { default = {} }

variable "load_balancers" { default = {} }

variable "load_balancer_services" { default = {} }

variable "load_balancer_targets" { default = {} }

variable "load_balancer_networks" { default = {} }

variable "managed_certificates" { default = {} }

variable "uploaded_certificates" { default = {} }

variable "snapshots" { default = {} }

variable "storage_boxes" { default = {} }

variable "storage_box_snapshots" { default = {} }

variable "storage_box_subaccounts" { default = {} }

variable "zones" { default = {} }

variable "zone_records" { default = {} }

variable "zone_rrsets" { default = {} }
