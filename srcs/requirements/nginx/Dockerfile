FROM debian:bullseye

RUN apt-get -y update && apt-get -y upgrade && apt install nginx -y

CMD ["nginx", "-g", "daemon off;"]

