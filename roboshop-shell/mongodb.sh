cp mongo.repo /etc/yum.repos.d/mongo.repo

dnf install -y mongodb-org
systemctl enable mongod
systemctl start mongod

sed -i 's/bindIp: localhost/bindIp: 0.0.0.0/' /etc/mongod.conf

systemctl restart mongod