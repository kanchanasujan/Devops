resource "null_resource" "cnt" {
  count = 5
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
   subnet_id                     = "/subscriptions/50b00215-bc86-413d-a70f-7f58601e6267/resourceGroups/denmark-east-rg/providers/Microsoft.Network/virtualNetworks/rhel10-vm/subnets/rhel10-vmSubnet"
   private_ip_address_allocation = "Dynamic"
  }
}

