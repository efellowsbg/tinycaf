resource "hcloud_load_balancer_service" "main" {
  load_balancer_id = local.load_balancer_id
  protocol         = var.settings.protocol

  listen_port      = try(var.settings.listen_port, null)
  destination_port = try(var.settings.destination_port, null)
  proxyprotocol    = try(var.settings.proxyprotocol, null)

  dynamic "http" {
    for_each = can(var.settings.http) ? [1] : []
    content {
      sticky_sessions = try(var.settings.http.sticky_sessions, null)
      cookie_name     = try(var.settings.http.cookie_name, null)
      cookie_lifetime = try(var.settings.http.cookie_lifetime, null)
      certificates    = try(var.settings.http.certificates, null)
      redirect_http   = try(var.settings.http.redirect_http, null)
    }
  }

  dynamic "health_check" {
    for_each = can(var.settings.health_check) ? [1] : []
    content {
      protocol = var.settings.health_check.protocol
      port     = var.settings.health_check.port
      interval = try(var.settings.health_check.interval, null)
      timeout  = try(var.settings.health_check.timeout, null)
      retries  = try(var.settings.health_check.retries, null)

      dynamic "http" {
        for_each = can(var.settings.health_check.http) ? [1] : []
        content {
          domain       = try(var.settings.health_check.http.domain, null)
          path         = try(var.settings.health_check.http.path, null)
          response     = try(var.settings.health_check.http.response, null)
          tls          = try(var.settings.health_check.http.tls, null)
          status_codes = try(var.settings.health_check.http.status_codes, null)
        }
      }
    }
  }
}
