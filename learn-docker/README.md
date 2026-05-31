#Install Docker
sudo dnf -y install dnf-plugins-core      
sudo dnf config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo      
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y      
sudo systemctl start docker      
sudo systemctl enable docker      
sudo usermod -a -G docker devops      
sudo curl -Lo /bin/kind https://kind.sigs.k8s.io/dl/v0.31.0/kind-linux-amd64      
sudo curl -Lo /bin/kubectl https://dl.k8s.io/release/v1.36.1/bin/linux/amd64/kubectl      
sudo chmod ugo+x /bin/kind /bin/kubectl      
sudo kind create cluster --name rhel10-cluster

sudo docker ps
cat /etc/group | grep docker
sudo usermod -aG docker $USER

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

#creates a custom Docker container image from a source blueprint located in your current folder or directory.
docker build -t local/nginx .

#Runs isolated; no ports are accessible from your host machine.
docker run -d local/nginx

#Automatically maps exposed container ports to random high-numbered ports on your host
docker run -d -P local/nginx

docker images
docker ps -a
docker inspect <container_id>
curl <ipaddress>

#Check logs
docker exec -it <container_id> bash
cd /usr/share/nginx/html