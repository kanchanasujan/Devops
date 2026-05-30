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

#Check logs
docker exec -it <container_id> bash
cd /usr/share/nginx/html