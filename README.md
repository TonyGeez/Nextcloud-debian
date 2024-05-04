# Nextcloud Automatic Installer

This repository contains a Bash script for automating the installation of Nextcloud on a Debian 12 server. It sets up all necessary dependencies including Apache, PHP, MySQL, and configures them along with Nextcloud without manual intervention.

## Overview

Nextcloud offers industry-leading on-premises file sync and online collaboration technology. Our goal is to provide secure and compliant file syncing and sharing features on a robust and scalable server setup.

## Features

- Automatic installation of Apache, PHP, and MySQL.
- Configures PHP and Apache to suit Nextcloud.
- Sets up a MySQL database and user specifically for Nextcloud.
- Downloads and configures the latest version of Nextcloud.

## Installation

To use this script:

1. Ensure you have a fresh Debian 12 server ready.
2. SSH into your server as a user with sudo privileges.
3. Download the script from this repository.
4. Make the script executable:
   ```bash
   chmod +x install_nextcloud.sh
