
provider "azurerm" {
   features {}
}
module "APG" {
  source   = "./aishu/APG"
  apgname    = var.apgname
  rgname   = var.rg_name
  location = var.location
}
module "RG" {
    source   = "./aishu/RG" #A 
    rgname   = var.rg_name     #B 
    location = var.location
}
module "ACR" {
    source   = "./aishu/ACR" #A 
    rgname   = var.rg_name     #B 
    location = var.location
}
