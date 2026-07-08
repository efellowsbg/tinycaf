output "type" {
  value = hcloud_load_balancer_target.main.type
}

output "load_balancer_id" {
  value = hcloud_load_balancer_target.main.load_balancer_id
}

output "server_id" {
  value = hcloud_load_balancer_target.main.server_id
}

output "label_selector" {
  value = hcloud_load_balancer_target.main.label_selector
}

output "use_private_ip" {
  value = hcloud_load_balancer_target.main.use_private_ip
}
