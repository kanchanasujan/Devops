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


mongodb://mongodb:RoboShop@1@<Server_IP_Address>:27017/

python3 -m pip show ansible | grep Location

sudo dnf list all | grep ansible-core

sudo dnf install python3-pip -y

pip3.12 install ansible

pip list | grep ansible

ansible -i test.ini all --list-hosts

ansible -i sample.ini all -m ping -u devops -k

ansible-playbook -i sample.ini test.yml -u devops -k

yum list installed | grep nginx

ansible-playbook -i 10.0.0.5, 01-sample.yml -e ansible_user=devops -e ansible_password=Devops@12345