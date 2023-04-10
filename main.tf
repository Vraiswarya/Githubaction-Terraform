
provider "azurerm" {
   features {}
}
module "APG" {
  source   = "./aishu/APG"
  apgname    = var.apgname
  rgname   = var.rgname
  location = var.location
}
module "RG" {
    source   = "./aishu/RG" #A 
    rgname   = var.rgname     #B 
    location = var.location
}
module "ACR" {
    source   = "./aishu/ACR" #A 
    rgname   = var.rgname     #B 
    location = var.location
}
