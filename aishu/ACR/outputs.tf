output "azurerm_container_registry" {
  value = {
    rg_name = azurerm_container_registry.acr.name #A 
  }
}