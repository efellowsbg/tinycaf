locals {
  use_storage = try(var.settings, null) != null
  use_law     = try(var.settings, null) != null
}
