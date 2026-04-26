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


sudo apt-get purge mysql-server mysql-client mysql-common mysql-server-core-* mysql-client-core-*
sudo apt-get autoremove
sudo apt-get autoclean


