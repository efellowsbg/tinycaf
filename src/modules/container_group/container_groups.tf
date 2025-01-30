resource "azurerm_container_group" "main" {
  name                = var.settings.name
  resource_group_name = local.resource_group_name
  location            = local.location
  tags                = local.tags

  os_type                             = try(var.settings.os_type, "Linux")
  subnet_ids                          = try(local.subnet_ids, null)
  ip_address_type                     = try(var.settings.ip_address_type, null)
  sku                                 = try(var.settings.sku, null)
  dns_name_label                      = try(var.settings.dns_name_label, null)
  dns_name_label_reuse_policy         = try(var.settings.dns_name_label_reuse_policy, null)
  key_vault_key_id                    = try(var.settings.key_vault_key_id, null)
  key_vault_user_assigned_identity_id = try(var.settings.key_vault_user_assigned_identity_id, null)
  priority                            = try(var.settings.priority, null)
  restart_policy                      = try(var.settings.restart_policy, null)
  zones                               = try(var.settings.zones, null)

  dynamic "container" {
    for_each = var.settings.container

    content {
      name   = container.value.name
      image  = container.value.image
      cpu    = container.value.cpu
      memory = container.value.memory

      cpu_limit    = try(container.value.cpu_limit, null)
      memory_limit = try(container.value.memory_limit, null)

      dynamic "ports" {
        for_each = try(container.ports[*], {})

        content {
          port     = try(ports.value.port, null)
          protocol = try(ports.value.protocol, null)
        }
      }

      dynamic "environment_variables" {
        for_each = try(container.environment_variables[*], {})

        content {
          name  = environment_variables.value.name
          value = environment_variables.value.value
        }
      }
    }
  }

  dynamic "identity" {
    for_each = try(var.settings.identity[*], {})

    content {
      type         = try(identity.value.type, null)
      identity_ids = try(local.identity_ids, null)
    }
  }

  dynamic "dns_config" {
    for_each = try(var.settings.dns_config[*], {})

    content {
      nameservers    = dns_config.value.nameservers
      search_domains = try(dns_config.value.search_domains, null)
      options        = try(dns_config.value.options, null)
    }
  }

  dynamic "diagnostics" {
    for_each = try(var.settings.diagnostics[*], {})

    content {
      dynamic "log_analytics" {
        for_each = try(var.diagnostics.log_analytics[*], {})

        content {
          workspace_id  = log_analytics.value.workspace_id
          workspace_key = log_analytics.value.workspace_key
          log_type      = try(log_analytics.value.log_type, null)
          metadata      = try(log_analytics.value.metadata, null)
        }
      }
    }
  }

  dynamic "exposed_port" {
    for_each = try(var.settings.exposed_port[*], {})

    content {
      port     = try(exposed_port.value.port, null)
      protocol = try(exposed_port.value.protocol, null)
    }
  }

  dynamic "image_registry_credential" {
    for_each = try(var.settings.image_registry_credential[*], {})

    content {
      server                    = try(image_registry_credential.value.server, null)
      user_assigned_identity_id = try(image_registry_credential.value.user_assigned_identity_id, null)
      username                  = try(image_registry_credential.value.username, null)
      password                  = try(image_registry_credential.value.password, null)
    }
  }

  dynamic "init_container" {
    for_each = try(var.settings.init_container[*], {})

    content {
      name     = init_container.value.name
      image    = init_container.value.image
      commands = try(init_container.value.commands, null)

      dynamic "environment_variables" {
        for_each = try(var.init_container.environment_variables[*], {})
        content {
          name  = environment_variables.value.name
          value = environment_variables.value.value
        }
      }

      dynamic "secure_environment_variables" {
        for_each = try(var.init_container.secure_environment_variables[*], {})
        content {
          name  = secure_environment_variables.value.name
          value = secure_environment_variables.value.value
        }
      }

      dynamic "volume" {
        for_each = try(var.init_container.volume[*], {})

        content {
          name       = volume.value.name
          mount_path = volume.value.mount_path
        }
      }

      dynamic "security" {
        for_each = try(var.init_container.security[*], {})

        content {
          privilege_enabled = security.value.privilege_enabled
        }
      }
    }
  }

  dynamic "timeouts" {
    for_each = try(var.settings.timeouts[*], {})

    content {
      read   = try(timeouts.value.read, null)
      create = try(timeouts.value.create, null)
      update = try(timeouts.value.update, null)
      delete = try(timeouts.value.delete, null)
    }
  }
}


# container {
#   name   = "hello-world"
#   image  = "mcr.microsoft.com/azuredocs/aci-helloworld:latest"
#   cpu    = "0.5"
#   memory = "1.5"

#   ports {
#     port     = 443
#     protocol = "TCP"
#   }
# }

# container {
#   name   = "sidecar"
#   image  = "mcr.microsoft.com/azuredocs/aci-tutorial-sidecar"
#   cpu    = "0.5"
#   memory = "1.5"
# }
