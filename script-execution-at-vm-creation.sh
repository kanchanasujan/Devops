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

# Verify installations in the log
git --version >> /var/log/vm-init.log
terraform --version >> /var/log/vm-init.log
az --version >> /var/log/vm-init.log