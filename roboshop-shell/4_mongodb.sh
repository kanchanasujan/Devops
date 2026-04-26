cp mongo.repo /etc/yum.repos.d/mongo.repo

dnf install -y mongodb-org
systemctl enable mongod
systemctl start mongod

sed -i 's/bindIp: 10.0.0.7/bindIp: 0.0.0.0/' /etc/mongod.conf

systemctl restart mongod