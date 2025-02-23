#!/bin/bash

# Charger les variables d'environnement
#export $(grep -v '^#' .env | xargs)

# Se déplacer dans le répertoire WordPress
cd /var/www/html

# Télécharger et configurer WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

# Télécharger WordPress
./wp-cli.phar core download --allow-root

# Créer le fichier de configuration avec les infos de la BDD
./wp-cli.phar config create --dbname="$MYSQL_DATABASE" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --dbhost="mariadb" --allow-root

# Installer WordPress avec les infos de l'admin
./wp-cli.phar core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --allow-root

# Créer l'utilisateur admin "zachamou" si ce n'est pas déjà fait
if ! ./wp-cli.phar user get "$WP_ADMIN_USER" --allow-root > /dev/null 2>&1; then
    echo "Création de l'utilisateur admin..."
    ./wp-cli.phar user create "$WP_ADMIN_USER" "$WP_ADMIN_EMAIL" --role=administrator --user_pass="$WP_ADMIN_PASSWORD" --allow-root
fi

# Créer l'utilisateur normal s'il n'existe pas
if ! ./wp-cli.phar user list --allow-root | grep -q "$WP_NORMAL_USER"; then
    ./wp-cli.phar user create "$WP_NORMAL_USER" "$WP_NORMAL_EMAIL" --role=subscriber --user_pass="$WP_NORMAL_PASSWORD" --allow-root
fi

# Lancer PHP-FPM
php-fpm8.2 -F
