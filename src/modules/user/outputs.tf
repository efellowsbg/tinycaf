output "email" {
  value = var.settings.email
}
output "other_mails" {
  value = data.azuread_user.main.other_mails
}
output "mobile_phone" {
  value = data.azuread_user.main.mobile_phone
}
output "display_name" {
  value = data.azuread_user.main.display_name
}
output "nickname" {
  value = data.azuread_user.main.mail_nickname
}
output "name_array" {
  value = [data.azuread_user.main.given_name, data.azuread_user.main.surname]
}
output "object_id" {
  value = data.azuread_user.main.object_id
}
output "is_guest" {
  value = data.azuread_user.main.user_type == "Guest"
}
