resource "azurerm_network_interface" "main" {
  count               = var.vm_count
  name                = "${var.component_name}-${var.env}-nic${count.index}"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name

  ip_configuration {
    name                = "${var.component_name}-${var.env}-nic${count.index}"
    subnet_id           = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  count               = var.vm_count
  name                = "${var.component_name}-${var.env}-vm${count.index}"
  location              = data.azurerm_resource_group.main.location
  resource_group_name   = data.azurerm_resource_group.main.name
  network_interface_ids = [azurerm_network_interface.main[count.index].id]
  size               = "Standard_B1ms"
  admin_password = "Devops@12345"
  admin_username = "devops"
  source_image_id = var.image_id
  disable_password_authentication = false
  secure_boot_enabled = true
  vtpm_enabled        = true
 
   user_data = base64encode(templatefile("${path.root}/userdata.sh", {
    component_name = var.component_name
    env            = var.env
  }))

  
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}

data "azurerm_network_security_group" "existing" {
  count               =  var.vm_count
  name                = "network-grp"
  resource_group_name = data.azurerm_resource_group.main.name
}

resource "azurerm_network_interface_security_group_association" "global_assoc" {
  count                     = var.vm_count
  network_interface_id      = azurerm_network_interface.main[count.index].id
  network_security_group_id = data.azurerm_network_security_group.existing[count.index].id

  # Forces Terraform to wait until the VM instances are completely built
  depends_on = [ azurerm_linux_virtual_machine.main ]
}

resource "azurerm_dns_a_record" "main" {
  name                = "${var.component_name}-${var.env}"
  zone_name           = "kanchanadevisujan.online"
  resource_group_name = data.azurerm_resource_group.main.name
  ttl                 = 30
  records             = [azurerm_network_interface.main[0].private_ip_address]
}

