data "azurerm_resource_group" "main" {
  name = var.rgname
}

data "azurerm_network_security_group" "existing" {
  name                = "network-grp"
  resource_group_name = var.rgname
}

