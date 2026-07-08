output "id" {
  value = hcloud_managed_certificate.main.id
}

output "name" {
  value = hcloud_managed_certificate.main.name
}

output "domain_names" {
  value = hcloud_managed_certificate.main.domain_names
}

output "certificate" {
  value = hcloud_managed_certificate.main.certificate
}

output "fingerprint" {
  value = hcloud_managed_certificate.main.fingerprint
}

output "created" {
  value = hcloud_managed_certificate.main.created
}

output "not_valid_before" {
  value = hcloud_managed_certificate.main.not_valid_before
}

output "not_valid_after" {
  value = hcloud_managed_certificate.main.not_valid_after
}

output "labels" {
  value = hcloud_managed_certificate.main.labels
}
