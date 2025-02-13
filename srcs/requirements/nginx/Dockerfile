FROM debian:bullseye

RUN apt-get -y update && apt-get -y upgrade && apt install nginx -y

COPY default /etc/nginx/sites-available/.

CMD ["nginx", "-g", "daemon off;"]

