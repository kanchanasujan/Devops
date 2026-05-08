# Configure the Microsoft Azure Provider
provider "azurerm" {
  features{}
}

resource "azurerm_network_interface" "main" {
  name                = "frontend-vm"
  location            = "Denmark East"
  resource_group_name = "denmark-east-rg"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "/subscriptions/50b00215-bc86-413d-a70f-7f58601e6267/resourceGroups/denmark-east-rg/providers/Microsoft.Network/virtualNetworks/rhel10-vm/subnets/rhel10-vmSubnet"
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                  = "frontend-vm"
  location              = "Denmark East"
  resource_group_name   = "denmark-east-rg"
  network_interface_ids = [azurerm_network_interface.main.id]
  size               = "Standard_B1ms"

  source_image_id = "/subscriptions/50b00215-bc86-413d-a70f-7f58601e6267/resourceGroups/denmark-east-rg/providers/Microsoft.Compute/galleries/rhel10/images/1.0.0/versions/1.0.0"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

 
  admin_password = "Devops@12345"
  admin_username = "devops"

  disable_password_authentication = false

  secure_boot_enabled = true
  vtpm_enabled        = true

}