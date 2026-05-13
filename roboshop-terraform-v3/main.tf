resource "azurerm_public_ip" "main" {
  for_each  = var.components
  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "main" {
  for_each  = var.components
  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          =  "${each.key}-nic"
    subnet_id                     = "/subscriptions/50b00215-bc86-413d-a70f-7f58601e6267/resourceGroups/denmark-east-rg/providers/Microsoft.Network/virtualNetworks/rhel10-vm/subnets/rhel10-vmSubnet"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main[each.key].id
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  for_each  = var.components
  name                  = "${each.key}-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.main[each.key].id]
  size               = each.value

  source_image_id = var.image_id

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

data "azurerm_network_security_group" "existing" {
  for_each  = var.components
  name                = "network-grp"
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_interface_security_group_association" "global_assoc" {
  for_each                  = azurerm_network_interface.main
  network_interface_id      = each.value.id
  network_security_group_id = data.azurerm_network_security_group.existing[each.key].id

  # Forces Terraform to wait until the VM instances are completely built
  depends_on = [ azurerm_linux_virtual_machine.main ]
}


resource "azurerm_dns_a_record" "main" {
  for_each = var.components
  name                = "${each.key}-dev"
  zone_name           = "kanchanadevisujan.online"
  resource_group_name = var.resource_group_name
  ttl                 = 30
  records             = [azurerm_network_interface.main[each.key].private_ip_address]
}

resource "null_resource" "ansible" {
    depends_on = [azurerm_linux_virtual_machine.main]

  for_each = var.components
  
  triggers = {
    instance_id = azurerm_linux_virtual_machine.main[each.key].id
  }

connection {
      type = "ssh"
      user = "devops"
      password = "Devops@12345"
      host = azurerm_network_interface.main[each.key].private_ip_address
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install git -y",
      "sudo dnf install python3-pip -y",
      "sudo pip3.12 install ansible",
      "ansible-pull -i localhost, -U https://github.com/kanchanasujan/Devops.git roboshop-ansible-v3/roboshop.yml -e component_name=${each.key} -e env=dev",
    ]
  }
}
