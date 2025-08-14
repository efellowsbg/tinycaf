output "id" {
  value = azurerm_web_application_firewall_policy.main.id
}

output "waf_policies" {
  value = {
    for k, v in azurerm_web_application_firewall_policy.main :
    k => {
      id   = v.id
      name = v.name
    }
  }
}
