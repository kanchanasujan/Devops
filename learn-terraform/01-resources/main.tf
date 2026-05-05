resource "azurerm_resource_group" "WestEurope_Resource_group" {
  name     = "WestEurope_rg"
  location = "West Europe"
}

provider "azurerm" {
   features {}
}