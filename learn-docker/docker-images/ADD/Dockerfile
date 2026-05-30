FROM          docker.io/redhat/ubi10
RUN           dnf install nginx -y
ENTRYPOINT    ["nginx", "-g", "daemon off;"]
EXPOSE        80
COPY          index.html /usr/share/nginx/html/index.html