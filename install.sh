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
sudo apt update && sudo apt upgrade -y

# Install Apache, PHP, and necessary PHP extensions
echo "Installing Apache and PHP..."
sudo apt install apache2 libapache2-mod-php php-gd php-json php-mysql php-curl php-mbstring \
                 php-intl php-imagick php-xml php-zip -y

# Enable Apache mods
sudo a2enmod rewrite headers env dir mime

# Install MariaDB Server
echo "Installing MariaDB Server..."
sudo apt install mariadb-server -y

# Configure MariaDB database and user for Nextcloud
echo "Configuring MariaDB..."
sudo mysql -e "CREATE DATABASE ${DB_NAME};"
sudo mysql -e "CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';"
sudo mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Install Nextcloud
echo "Installing Nextcloud..."
sudo mkdir -p ${NEXTCLOUD_DIR}
cd ${NEXTCLOUD_DIR}/..
sudo wget https://download.nextcloud.com/server/releases/latest.tar.bz2
sudo tar -xjf latest.tar.bz2 -C ${NEXTCLOUD_DIR} --strip-components=1
sudo rm latest.tar.bz2
sudo chown -R www-data:www-data ${NEXTCLOUD_DIR}

# Configure Apache to serve Nextcloud
echo "Configuring Apache..."
NEXTCLOUD_CONF="/etc/apache2/sites-available/nextcloud.conf"
echo "<VirtualHost *:80>
    ServerName ${DOMAIN_OR_IP}
    DocumentRoot ${NEXTCLOUD_DIR}
    <Directory ${NEXTCLOUD_DIR}/>
        Require all granted
        AllowOverride All
        Options FollowSymLinks MultiViews

        <IfModule mod_dav.c>
            Dav off
        </IfModule>
    </Directory>
</VirtualHost>" | sudo tee $NEXTCLOUD_CONF

sudo a2ensite nextcloud.conf
sudo a2dissite 000-default.conf
sudo systemctl restart apache2

echo "Nextcloud installation completed successfully!"
echo "You can access Nextcloud at: http://${DOMAIN_OR_IP}/"
