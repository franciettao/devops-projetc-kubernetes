#!/bin/bash
# WordPress Setup Script

# Set variables
DB_NAME="wordpress"
DB_USER="wordpress_user"
DB_="wordpress_password"

# Check if MySQL server is installed
if ! command -v mysql &> /dev/null
then
   echo "MySQL server not found. Installing..."
   sudo apt-get update
   sudo apt-get install -y mysql-server
fi

# Secure the MySQL installation
sudo mysql_secure_installation

# Create the WordPress database
echo "Creating the WordPress database..."
mysql -e "CREATE DATABASE $DB_NAME;"

# Create the WordPress user
echo "Creating the WordPress user..."
mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASS';"

# Flush the privileges
echo "Flushing the privileges..."
mysql -e "FLUSH PRIVILEGES;"

# Download the latest WordPress version
echo "Downloading the latest WordPress version..."
wget https://wordpress.org/latest.tar.gz

# Extract the WordPress files
echo "Extracting the WordPress files..."
tar -xzvf latest.tar.gz

# Remove the downloaded archive
echo "Removing the downloaded archive..."
rm latest.tar.gz

# Move the WordPress files to the web root
echo "Moving the WordPress files to the web root..."
sudo mv wordpress/* /var/www/html/

# Change the ownership of the WordPress files
echo "Changing the ownership of the WordPress files..."
sudo chown -R www-data:www-data /var/www/html/

# Set the necessary permissions
echo "Setting the necessary permissions..."
sudo chmod -R 755 /var/www/html/

# Open the WordPress configuration file
echo "Opening the WordPress configuration file..."
sudo nano /var/www/html/wp-config.php

# Update the database credentials in the configuration file
# Replace the placeholders with the actual values
sed -i "s/database_name_here/$DB_NAME/g" /var/www/html/wp-config.php
sed -i "s/username_here/$DB_USER/g" /var/www/html/wp-config.php
sed -i "s/password_here/$DB_PASS/g" /var/www/html/wp-config.php

# Finish the WordPress installation
echo "Finish the WordPress installation by accessing the website in a web browser."