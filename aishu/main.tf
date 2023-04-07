
provider "azurerm" {
   features {}
}
data "azurerm_resource_group" "resourcegrp" {
    name= var.rg_name
    location= var.location
}
#acr
data "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = data.azurerm_resource_group.resourcegrp.name
  location            = var.location
  sku                 = "Premium"
  admin_enabled       = false
 
}
data "azurerm_virtual_network" "vnet_resource" {
  name                = "vnet-dq-test-euwe-002"
  resource_group_name = data.azurerm_resource_group.resourcegrp.name
  location            = data.azurerm_resource_group.resourcegrp.location
  address_space       = ["10.103.70.0/24"]
}

data "azurerm_subnet" "frontend" {
  name                 = "frontend"
  resource_group_name  = data.azurerm_resource_group.resourcegrp.name
  virtual_network_name = data.azurerm_virtual_network.vnet_resource.name
  address_prefixes     = ["10.103.70.165/28"]
}

data "azurerm_subnet" "backend" {
  name                 = "backend"
  resource_group_name  = data.azurerm_resource_group.resourcegrp.name
  virtual_network_name = data.azurerm_virtual_network.vnet_resource.name
  address_prefixes     = ["10.254.2.0/24"]
}

resource "azurerm_public_ip" "example" {
  name                = "Publicip_apg"
  resource_group_name = data.azurerm_resource_group.resourcegrp.name
  location            = data.azurerm_resource_group.resourcegrp.location
  allocation_method   = "Dynamic"
}

# since these variables are re-used - a locals block makes this more maintainable
locals {
  backend_address_pool_name      = "${data.azurerm_virtual_network.vnet_resource.name}-beap"
  frontend_port_name             = "${data.azurerm_virtual_network.vnet_resource.name}-feport"
  frontend_ip_configuration_name = "${data.azurerm_virtual_network.vnet_resource.name}-feip"
  http_setting_name              = "${data.azurerm_virtual_network.vnet_resource.name}-be-htst"
  listener_name                  = "${data.azurerm_virtual_network.vnet_resource.name}-httplstn"
  request_routing_rule_name      = "${data.azurerm_virtual_network.vnet_resource.name}-rqrt"
  redirect_configuration_name    = "${data.azurerm_virtual_network.vnet_resource.name}-rdrcfg"
}

resource "azurerm_application_gateway" "network" {
  name                = "agw-dq-test02"
  resource_group_name = data.azurerm_resource_group.resourcegrp.name
  location            = data.azurerm_resource_group.resourcegrp.location

  sku {
    tier     = "WAF_v2 "
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = data.azurerm_subnet.frontend.id
  }

  frontend_port {
    name = local.frontend_port_name
    port = 80
  }

  frontend_ip_configuration {
    name                 = local.frontend_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.example.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name                  = local.http_setting_name
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name             = local.frontend_port_name
    protocol                       = "Https"
  }

  request_routing_rule {
    name                       = local.request_routing_rule_name
    rule_type                  = "Basic"
    http_listener_name         = local.listener_name
    backend_address_pool_name  = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
  }
}