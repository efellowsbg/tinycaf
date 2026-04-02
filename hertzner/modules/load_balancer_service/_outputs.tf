output "id" {
  value = hcloud_load_balancer_service.main.id
}

output "load_balancer_id" {
  value = hcloud_load_balancer_service.main.load_balancer_id
}

output "protocol" {
  value = hcloud_load_balancer_service.main.protocol
}

output "listen_port" {
  value = hcloud_load_balancer_service.main.listen_port
}

output "destination_port" {
  value = hcloud_load_balancer_service.main.destination_port
}
