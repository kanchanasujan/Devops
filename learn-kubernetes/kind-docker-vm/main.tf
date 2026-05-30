terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.2.4"
    }
  }
}

variable "vm_name" {
  default = "docker"
}


resource "azurerm_public_ip" "main" {
  name                = var.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "main" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          =  "${var.vm_name}-nic"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                  = "${var.vm_name}-vm"
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.main.id]
  size                  = "Standard_B1ms"
  source_image_id       = var.image_id

  admin_password = "Devops@12345"
  admin_username = "devops"
  disable_password_authentication = false
  secure_boot_enabled = true
  vtpm_enabled        = true

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}

data "azurerm_network_security_group" "existing" {
  name                = "network-grp"
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_interface_security_group_association" "global_assoc" {
  #for_each                     = azurerm_network_interface.main
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = data.azurerm_network_security_group.existing.id

  # Forces Terraform to wait until the VM instances are completely built
  depends_on = [ azurerm_linux_virtual_machine.main ]
}

output "ip" {
  value = azurerm_public_ip.main.ip_address
}

resource "null_resource" "kind-setup" {
  depends_on = [azurerm_linux_virtual_machine.main]

  provisioner "remote-exec" {
    connection {
      host     = azurerm_public_ip.main.ip_address
      user     = "devops"
      password = "Devops@12345"
      type     = "ssh"
    }

    inline = [
      "sudo dnf -y install dnf-plugins-core",
      "sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo",
      "sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo usermod -a -G docker devops",
      "sudo curl -Lo /bin/kind https://kind.sigs.k8s.io/dl/v0.31.0/kind-linux-amd64",
      "sudo curl -Lo /bin/kubectl https://dl.k8s.io/release/v1.36.1/bin/linux/amd64/kubectl",
      "sudo chmod ugo+x /bin/kind /bin/kubectl",
      "sudo kind create cluster --name rhel10-cluster"
    ]

  }
}

