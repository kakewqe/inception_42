FROM debian:bullseye-slim

# Mise à jour et installation des paquets nécessaires pour PHP
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    ca-certificates \
    apt-transport-https \
    curl \
    lsb-release \
    && curl -sS https://packages.sury.org/php/README.txt | bash - \
    && apt-get update \
    && apt-get install -y php8.2-fpm \
    && rm -rf /var/lib/apt/lists/*

# Créer le répertoire pour le socket PHP-FPM et définir les bonnes permissions
RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

COPY www.conf /etc/php/8.2/fpm/pool.d/.

# Lancer PHP-FPM en mode premier plan
CMD ["php-fpm8.2", "-F"]

