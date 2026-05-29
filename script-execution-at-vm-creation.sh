#!/bin/bash
# Update the package manager cache
sudo yum check-update

# Install Git
sudo yum install -y git
git clone https://github.com/kanchanasujan/Devops.git

#Install Make
sudo dnf install -y make

#Install Terraform
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform

#Install Azure CLI
sudo rpm --import https://packages.microsoft.com/keys/microsoft-2025.asc
sudo dnf install -y https://packages.microsoft.com/config/rhel/10/packages-microsoft-prod.rpm
sudo dnf -y install azure-cli

#Install Docker
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo systemctl start docker
sudo systemctl enable docker


docker ps
docker ps a 
sudo systemctl stop docker.socket
sudo systemctl disable docker.socket

docker pull docker.io/library/nginx
docker pull httpd:latest

docker images
docker run nginx
docker run -d nginx

docker inspect <container_id>
curl ipaddress
docker run -d -p nginx

docker build .
docker build -f <filename> .

ENTRYPOINT :-
docker images
docker build -t local/nginx .
docker run -d local/nginx
docker ps -a
docker inspect <container_id>
curl <ipaddress>
docker run -d -P local/nginx


EXPOSE :-
docker build -t local/nginx .
docker run -d -P local/nginx
docker ps 



.




# Verify installations in the log
git --version >> /var/log/vm-init.log
terraform --version >> /var/log/vm-init.log
az --version >> /var/log/vm-init.log


resource "azurerm_public_ip" "nat_pip" {
  name                = "nat-gw-pip"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "nat_gateway" {
  name                    = "nat-gw"
  location                = var.rglocation
  resource_group_name     = var.rgname
  sku_name                = "Standard"
  idle_timeout_in_minutes = 4
  zones                   = ["1"]
}

resource "azurerm_nat_gateway_public_ip_association" "nat_gw_pip_assoc" {
   nat_gateway_id       = azurerm_nat_gateway.nat_gateway.id
   public_ip_address_id = azurerm_public_ip.nat_pip.id
}

resource "azurerm_subnet_nat_gateway_association" "subnet_nat_assoc" {
  subnet_id      = azurerm_subnet.subnet.id
  nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
}