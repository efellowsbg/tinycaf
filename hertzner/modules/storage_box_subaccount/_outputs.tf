output "id" {
  value = hcloud_storage_box_subaccount.main.id
}

output "storage_box_id" {
  value = hcloud_storage_box_subaccount.main.storage_box_id
}

output "name" {
  value = hcloud_storage_box_subaccount.main.name
}

output "server" {
  value = hcloud_storage_box_subaccount.main.server
}

output "username" {
  value = hcloud_storage_box_subaccount.main.username
}

output "labels" {
  value = hcloud_storage_box_subaccount.main.labels
}

output "password" {
  value     = hcloud_storage_box_subaccount.main.password
  sensitive = true
}
