resource "azurerm_application_gateway" "APG" {
  name                = var.apgname
  resource_group_name = var.rgname
  location            = var.location

  sku {
    tier     = "WAF_v2"
   
  }

  gateway_ip_configuration {
    name      = "dqgatewayipcon"
    subnet_id = "10.254.2.0/24"
  }

  frontend_port {
    name = "dqfrontendport"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "dqfrontipcon"
  }

  backend_address_pool {
    name = "dqbackendaddpool"
  }

  backend_http_settings {
    name                  = "dqbackendhttp"
    cookie_based_affinity = "Disabled"
    port                  = 80
    protocol              = "Http"
  }

  http_listener {
    name                           = "dqlistener"
    frontend_ip_configuration_name = "dqfrontipcon"
    frontend_port_name             = "dqfrontendport"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "dqroutingtable"
    rule_type                  = "Basic"
    http_listener_name         = "dqlistener"
    backend_address_pool_name  = "dqbackendaddpool"
    backend_http_settings_name = "dqbackendhttp"
  }
}
