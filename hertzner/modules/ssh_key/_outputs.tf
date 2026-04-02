output "id" {
  value = hcloud_ssh_key.main.id
}

output "name" {
  value = hcloud_ssh_key.main.name
}

output "public_key" {
  value = hcloud_ssh_key.main.public_key
}

output "fingerprint" {
  value = hcloud_ssh_key.main.fingerprint
}

output "labels" {
  value = hcloud_ssh_key.main.labels
}
