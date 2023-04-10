terraform{
    backend "azurerm"{
        resource_group_name ="rg_test1"
        storage_account_name="sdatatest01"
        container_name="myterraformstate"
        key="tfstatefile.json"
    }
}