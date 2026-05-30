FROM          docker.io/redhat/ubi10
RUN           dnf install nginx unzip -y
ENTRYPOINT    ["nginx", "-g", "daemon off;"]
EXPOSE        80
ADD           https://github.com/raghudevopsb89/roboshop-microservices/raw/refs/heads/main/artifacts/frontend-compiled.zip /usr/share/nginx/html/
WORKDIR       /usr/share/nginx/html
RUN           unzip -o frontend-compiled.zip
RUN           rm -f frontend-compiled.zip


