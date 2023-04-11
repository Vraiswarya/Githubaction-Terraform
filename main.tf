
provider "azurerm" {
   features {}
}

module "WAF" {
  source   = "./aishu/WAF"
  waf_name  = var.waf_name
  rg_name   = var.rg_name
  location = var.location
  
}

module "ACR" {
    source   = "./aishu/ACR" #A 
    rg_name  = var.rg_name     #B 
    acr_name = var.acr_name  
    location = var.location
}
