module "virtual_networks" {
  source   = "./modules/_networking/virtual_network"
  for_each = var.virtual_networks

  settings        = each.value
  global_settings = local.global_settings



  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups         = module.resource_groups
        network_security_groups = module.network_security_groups
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
  client_config = {
    landingzone_key = var.landingzone.key
  }
}


module "vnet_peerings" {
  source   = "./modules/_networking/vnet_peering"
  for_each = var.vnet_peerings

  settings        = each.value
  global_settings = local.global_settings


  resources = merge(
    {
      (var.landingzone.key) = {
        virtual_networks = module.virtual_networks
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "virtual_network_gateways" {
  source   = "./modules/_networking/virtual_network_gateway"
  for_each = var.virtual_network_gateways

  settings        = each.value
  global_settings = local.global_settings




  resources = merge(
    {
      (var.landingzone.key) = {
        virtual_networks = module.virtual_networks
        public_ips       = module.public_ips
        resource_groups  = module.resource_groups
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "public_ips" {
  source   = "./modules/_networking/public_ip"
  for_each = var.public_ips

  settings        = each.value
  global_settings = local.global_settings



  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups = module.resource_groups

      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "local_network_gateways" {
  source   = "./modules/_networking/local_network_gateway"
  for_each = var.local_network_gateways

  global_settings = var.global_settings
  settings        = each.value



  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups = module.resource_groups
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "private_dns_zones" {
  source   = "./modules/_networking/private_dns_zone"
  for_each = var.private_dns_zones

  global_settings = var.global_settings
  settings        = each.value


  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups  = module.resource_groups
        virtual_networks = module.virtual_networks
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "virtual_network_gateway_connections" {
  source   = "./modules/_networking/virtual_network_gateway_connections"
  for_each = var.virtual_network_gateway_connections

  global_settings = var.global_settings
  settings        = each.value


  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups          = module.resource_groups
        virtual_networks         = module.virtual_networks
        keyvaults                = module.keyvaults
        local_network_gateways   = module.local_network_gateways
        virtual_network_gateways = module.virtual_network_gateways
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "private_dns_a_records" {
  source   = "./modules/_networking/private_dns_a_record"
  for_each = var.private_dns_a_records

  settings        = each.value
  global_settings = local.global_settings


  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups   = module.resource_groups
        private_dns_zones = module.private_dns_zones
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "private_endpoints" {
  source   = "./modules/_networking/private_endpoint"
  for_each = var.private_endpoints

  settings        = each.value
  global_settings = local.global_settings



  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups   = module.resource_groups
        virtual_networks  = module.virtual_networks
        private_dns_zones = module.private_dns_zones
        storage_accounts  = module.storage_accounts
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "network_security_groups" {
  source   = "./modules/_networking/network_security_group"
  for_each = var.network_security_groups

  settings        = each.value
  global_settings = local.global_settings



  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups = module.resource_groups
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "nat_gateways" {
  source   = "./modules/_networking/nat_gateway"
  for_each = var.nat_gateways

  settings        = each.value
  global_settings = local.global_settings



  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups = module.resource_groups
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "nat_gateway_public_ip_associations" {
  source   = "./modules/_networking/nat_gateway_public_ip_association"
  for_each = var.nat_gateway_public_ip_association

  settings        = each.value
  global_settings = local.global_settings



  resources = merge(
    {
      (var.landingzone.key) = {
        nat_gateways = module.nat_gateways
        public_ips   = module.public_ips
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "subnet_nat_gateway_associations" {
  source   = "./modules/_networking/subnet_nat_gateway_association"
  for_each = var.subnet_nat_gateway_associations

  settings        = each.value
  global_settings = local.global_settings



  resources = merge(
    {
      (var.landingzone.key) = {
        nat_gateways     = module.nat_gateways
        virtual_networks = module.virtual_networks
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "subnet_route_table_associations" {
  source   = "./modules/_networking/subnet_route_table_association"
  for_each = var.subnet_route_table_associations

  settings        = each.value
  global_settings = local.global_settings



  resources = merge(
    {
      (var.landingzone.key) = {
        route_tables     = module.route_tables
        virtual_networks = module.virtual_networks
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "route_tables" {
  source   = "./modules/_networking/route_table"
  for_each = var.route_tables

  settings        = each.value
  global_settings = local.global_settings



  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups = module.resource_groups
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
  client_config = {
    landingzone_key = var.landingzone.key
  }
}

module "network_security_group_associations" {
  source   = "./modules/_networking/network_security_group_association"
  for_each = var.network_security_group_associations

  settings        = each.value
  global_settings = local.global_settings


  resources = merge(
    {
      (var.landingzone.key) = {
        resource_groups         = module.resource_groups
        network_security_groups = module.network_security_groups
        virtual_networks        = module.virtual_networks
      }
    },
    {
      for k, v in module.remote_states : k => v.outputs
    }
  )
  client_config = {
    landingzone_key = var.landingzone.key
  }
}
