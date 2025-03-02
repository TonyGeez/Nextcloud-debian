# Nextcloud Automatic Installer

This repository contains scripts for automating the installation and uninstallation of Nextcloud on a FRESH Debian 12 server with sudo right using an environment file for configuration settings. This setup makes it easy to customize, deploy, and remove Nextcloud without manual intervention.

## Repository Structure

- `install.sh`: Script to install Nextcloud.
- `uninstall.sh`: Script to uninstall Nextcloud.
- `config.env`: Environment configuration file.
- `README.md`: Documentation for the repository.
- 
Before running the installation script, configure the settings in `config.env` file. Here is what it typically looks like:

```env
NEXTCLOUD_DIR=/var/www/nextcloud
DB_NAME=nextcloud_db
DB_USER=nextcloud_user
DB_PASS=nextcloud_password
DOMAIN_OR_IP=example.com
```

## Installation
```bash
git clone https://github.com/TonyGeez/Nextcloud-debian/
cd Nextcloud-debian
vim config.env
# Or
nano config.env
chmod +x install.sh
./install.sh
```

Nextcloud will be installed at the configured domain or IP, and you can access it through your web browser.


## Uninstallation
Make sure to backup your machine before executing running uninstall.sh

To remove Nextcloud from your server:

```bash
chmod +x uninstall.sh
./uninstall.sh
```

This will remove all components related to Nextcloud installed by the install.sh script.

## Security
Please ensure your config.env file is not publicly accessible and consider using secure methods for managing passwords and sensitive information. Additionally, consider setting up HTTPS to secure the connection to your Nextcloud instance.

