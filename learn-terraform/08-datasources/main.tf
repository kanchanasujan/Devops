provider "azurerm" {
  features {}
}

data "azurerm_resource_group" "example" {
  name = "denmark-east-rg"
}

output "rg" {
  value = data.azurerm_resource_group.example
}
