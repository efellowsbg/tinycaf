output "id" {
  value = hcloud_storage_box.main.id
}

output "name" {
  value = hcloud_storage_box.main.name
}

output "location" {
  value = hcloud_storage_box.main.location
}

output "storage_box_type" {
  value = hcloud_storage_box.main.storage_box_type
}

output "server" {
  value = hcloud_storage_box.main.server
}

output "system" {
  value = hcloud_storage_box.main.system
}

output "username" {
  value = hcloud_storage_box.main.username
}

output "labels" {
  value = hcloud_storage_box.main.labels
}

output "password" {
  value     = hcloud_storage_box.main.password
  sensitive = true
}
