sudo yum install git
git --version
    git clone https://github.com/kanchanasujan/Devops.git
cd Devops/roboshop-shell-v1/
 git pull
 sudo bash frontend.sh

sudo systemctl status mysqld
mysql -u root -pRoboShop@1


systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue

sudo systemctl stop nginx
sudo dnf remove nginx
sudo rm -rf /etc/nginx /var/log/nginx /usr/share/nginx


mongodb://mongodb:RoboShop@1@<Server_IP_Address>:27017/

python3 -m pip show ansible | grep Location

sudo dnf list all | grep ansible-core

Ansible Installation :-
------------------------

sudo dnf install python3-pip -y

pip3.12 install ansible

pip list | grep ansible

------------------------------------------------------------------------------------------------------------------------------------------------

ansible -i test.ini all --list-hosts

ansible -i sample.ini all -m ping -u devops -k

ansible-playbook -i sample.ini test.yml -u devops -k

yum list installed | grep nginx

ansible-playbook -i 10.0.0.5, 01-sample.yml -e ansible_user=devops -e ansible_password=Devops@12345

ansible-playbook -i frontend-dev.kanchanadevisujan.online, frontend.yml -e ansible_user=devops -e ansible_password=Devops@12345

ansible-playbook -i frontend-dev.kanchanadevisujan.online, frontend.yml -e ansible_user=devops -e ansible_password=Devops@12345

ansible-playbook -i sample.ini -e ansible_user=devops -e ansible_password=Devops@12345 03-vars.yml


Terraform Installation :-
------------------------

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform

Azure CLI Installation :-
-----------------------

sudo rpm --import https://packages.microsoft.com/keys/microsoft-2025.asc
sudo dnf install -y https://packages.microsoft.com/config/rhel/10/packages-microsoft-prod.rpm
sudo dnf install azure-cli

https://login.microsoft.com/device

Terraform Execution :-
--------------------

terraform init
terraform plan
terraform  apply
terraform destroy
terraform apply -auto-approve

subnet id = /subscriptions/50b00215-bc86-413d-a70f-7f58601e6267/resourceGroups/denmark-east-rg/providers/Microsoft.Network/virtualNetworks/rhel10-vm/subnets/rhel10-vmSubnet

source_image_id = /subscriptions/50b00215-bc86-413d-a70f-7f58601e6267/resourceGroups/denmark-east-rg/providers/Microsoft.Compute/galleries/rhel10/images/1.0.0

az network nic show --resource-group denmark-east-rg --name frontend-nic --query "networkSecurityGroup.id"

ansible-pull -i localhost, -U https://github.com/kanchanasujan/Devops.git roboshop-ansible-v3/roboshop.yml -e component_name=frontend -e env=dev

data "azurerm_resource_group" "main" {
  name = ""denmark-east-rg"
}


terraform state rm 'module.ui["frontend"].azurerm_lb_backend_address_pool.main'
terraform state rm 'module.ui["frontend"].azurerm_lb_backend_address_pool_address.main'
