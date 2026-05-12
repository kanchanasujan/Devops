resource "null_resource" "a" {
  count = 10
}

provider "azurerm" {
  features {}
}

variable "components" {
  default = ["frontend", "mysql", "mongodb", "catalogue"]
}

resource "azurerm_network_interface" "private-ips" {
  count = 3
  name                = "${var.components[count.index]}-nic"
  location            = "Denmark East"
  resource_group_name = "denmark-east-rg"

  ip_configuration {
    name                          =  "${var.components[count.index]}-nic"
    subnet_id                     = "/subscriptions/3f2e42e1-ca06-4a99-8c56-be8d8ba306db/resourceGroups/denmark-east-rg/providers/Microsoft.Network/virtualNetworks/rhel10-vmVNET/subnets/rhel10-vmSubnet"
    private_ip_address_allocation = "Dynamic"
  }
}

