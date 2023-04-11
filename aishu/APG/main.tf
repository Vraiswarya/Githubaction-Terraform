

resource "azurerm_application_gateway" "APG" {
  name                = var.apgname
  resource_group_name = var.rg_name
  location            = var.location

  sku {
    name     = "Standard_Small"
    tier     = "WAF_v2"
   
  }

  gateway_ip_configuration {
    name      = "dqgatewayipcon"
    subnet_id = data.azurerm_subnet.frontend.id
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
