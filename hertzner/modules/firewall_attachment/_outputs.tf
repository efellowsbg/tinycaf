output "id" {
  value = hcloud_firewall_attachment.main.id
}

output "firewall_id" {
  value = hcloud_firewall_attachment.main.firewall_id
}

output "server_ids" {
  value = hcloud_firewall_attachment.main.server_ids
}

output "label_selectors" {
  value = hcloud_firewall_attachment.main.label_selectors
}
