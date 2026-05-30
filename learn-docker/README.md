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

# creates a custom Docker container image from a source blueprint located in your current folder or directory.
docker build -t local/nginx .

# Runs isolated; no ports are accessible from your host machine.
docker run -d local/nginx

# Automatically maps exposed container ports to random high-numbered ports on your host
docker run -d -P local/nginx

docker images
docker ps -a
docker inspect <container_id>
curl <ipaddress>

# Check logs
docker exec -it <container_id> bash
cd /usr/share/nginx/html