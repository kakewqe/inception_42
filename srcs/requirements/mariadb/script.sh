#!/bin/bash

mysql_install_db
mysqld
# Charger les variables d'environnement
source .env

# Attendre que MariaDB soit complètement démarré
echo "Starting MariaDB..."
mysqld_safe --skip-grant-tables &

# Attendre quelques secondes pour laisser le temps à MariaDB de démarrer
sleep 5

# Exécuter les commandes SQL pour la configuration
echo "Configuring MariaDB..."
mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
mysql -u root -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -u root -e "FLUSH PRIVILEGES;"

# Arrêter MariaDB proprement
echo "Shutting down MariaDB..."
mysqladmin -u root -p$MYSQL_ROOT_PASSWORD shutdown

# Attendre encore un peu avant de redémarrer MariaDB
sleep 2

# Redémarrer MariaDB de manière normale
echo "Restarting MariaDB..."
exec mysqld_safe
