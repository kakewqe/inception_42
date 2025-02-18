FROM debian:bullseye-slim

RUN apt-get update && apt-get upgrade -y && \
apt-get install -y ca-certificates apt-transport-https curl lsb-release && \
curl -sS https://packages.sury.org/php/README.txt | bash - && \
apt-get update && \
apt-get install -y php8.2 php8.2-fpm php8.2-mysqli && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

COPY www.conf /etc/php/8.2/fpm/pool.d/.

COPY script.sh .

RUN chmod +x script.sh

CMD ["./script.sh"]