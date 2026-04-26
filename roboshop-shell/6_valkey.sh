dnf install -y valkey
systemctl enable valkey
systemctl start valkey

sed -i 's/bind localhost/bind 0.0.0.0/' /etc/valkey/valkey.conf
sed -i 's/protected-mode yes/protected-mode no/' /etc/valkey/valkey.conf

systemctl restart valkey