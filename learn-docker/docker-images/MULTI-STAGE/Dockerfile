FROM          docker.io/redhat/ubi10 AS builder
RUN           curl -fsSL https://rpm.nodesource.com/setup_20.x | bash -
RUN           dnf install unzip nodejs -y
ADD           https://raw.githubusercontent.com/raghudevopsb89/roboshop-microservices/main/artifacts/frontend.zip /tmp/
WORKDIR       /tmp
RUN           unzip -o frontend.zip
RUN           npm install ; npm run build
#RUN           rm -rf /usr/share/nginx/html/*
#RUN           cp -r out/* /usr/share/nginx/html/





FROM          docker.io/redhat/ubi10
RUN           dnf install nginx -y
ENTRYPOINT    ["nginx", "-g", "daemon off;"]
EXPOSE        80
COPY          --from=builder /tmp/out/ /usr/share/nginx/html/