provider "azurerm" {
  features {}
}


resource "azurerm_public_ip" "frontend" {
  name                = "frontend"
  location            = "Denmark East"
  resource_group_name = "denmark-east-rg"
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "frontend" {
  name                = "frontend-nic"
  location            = "Denmark East"
  resource_group_name = "denmark-east-rg"

  ip_configuration {
    name                          =  "frontend-nic1"
    subnet_id                     = "/subscriptions/50b00215-bc86-413d-a70f-7f58601e6267/resourceGroups/denmark-east-rg/providers/Microsoft.Network/virtualNetworks/rhel10-vm/subnets/rhel10-vmSubnet"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.frontend.id
  }
}

resource "azurerm_linux_virtual_machine" "frontend" {
  name                  = "frontend-dev"
  location              = "Denmark East"
  resource_group_name   = "denmark-east-rg"
  network_interface_ids = [azurerm_network_interface.frontend.id]
  size               = "Standard_B1s"

  source_image_id = "/subscriptions/50b00215-bc86-413d-a70f-7f58601e6267/resourceGroups/denmark-east-rg/providers/Microsoft.Compute/galleries/rhel/images/1.0.0"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_password = "DevOps@12345"
  admin_username = "devops"

  disable_password_authentication = false

  secure_boot_enabled = true
  vtpm_enabled        = true

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "devops"
      password = "Devops@12345"
      host = azurerm_network_interface.frontend.private_ip_address
    }

    inline = [
      "sudo dnf install nginx -y",
      "sudo systemctl start nginx"
    ]

  }

}

resource "azurerm_dns_a_record" "frontend" {
  name                = "frontend-dev"
  zone_name           = "kanchanadevisujan.online"
  resource_group_name = "denmark-east-rg"
  ttl                 = 30
  records             = [azurerm_network_interface.frontend.private_ip_address]
}