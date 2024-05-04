#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Load configuration from config.env file
if [ ! -f "config.env" ]; then
  echo "config.env configuration file not found"
  exit 1
fi
source config.env

# Update system
echo "Updating system packages..."
sudo apt update

# Stop Apache service
echo "Stopping Apache service..."
sudo systemctl stop apache2

# Remove Nextcloud directory
echo "Removing Nextcloud directory..."
sudo rm -rf ${NEXTCLOUD_DIR}

# Remove Apache configuration
echo "Removing Apache configuration..."
NEXTCLOUD_CONF="/etc/apache2/sites-available/nextcloud.conf"
sudo a2dissite nextcloud.conf
sudo rm $NEXTCLOUD_CONF
sudo systemctl reload apache2

# Drop Nextcloud database and user
echo "Dropping Nextcloud database and user..."
sudo mysql -e "DROP DATABASE IF EXISTS ${DB_NAME};"
sudo mysql -e "DROP USER IF EXISTS '${DB_USER}'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Uninstall MariaDB, Apache, and PHP packages
echo "Uninstalling MariaDB, Apache, and PHP..."
sudo apt remove --purge mariadb-server apache2 libapache2-mod-php php-gd php-json php-mysql php-curl php-mbstring \
                 php-intl php-imagick php-xml php-zip -y
sudo apt autoremove -y

echo "Nextcloud has been uninstalled successfully!"
