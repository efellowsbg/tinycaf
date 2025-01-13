terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.14.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

module "resource_group" {
  source   = "./modules/resource_group"
  for_each = var.resource_groups
  settings = each.value
}

module "managed_identities" {
  source = "./modules/managed_identity"
  for_each = var.managed_identities
  settings = each.value
  resources = {
    resource_groups = module.resource_group
  }
}
  
module "virtual_network" {
  source   = "./modules/network/virtual_networks"
  for_each = var.virtual_networks
  settings = each.value
  resources = {
    resource_groups = module.resource_group
  }
}
