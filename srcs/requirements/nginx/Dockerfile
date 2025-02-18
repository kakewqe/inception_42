FROM debian:bullseye-slim

RUN apt-get -y update && apt-get -y upgrade && apt install nginx -y 
RUN apt install openssl -y
RUN mkdir /etc/nginx/ssl

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=zachamou.42.fr/UID=zachamou"

COPY default /etc/nginx/sites-available/.
COPY nginx.conf /etc/nginx/.


CMD ["nginx", "-g", "daemon off;"]

