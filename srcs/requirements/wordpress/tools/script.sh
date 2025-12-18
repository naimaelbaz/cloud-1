#!/bin/bash

# Download WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Wait for MariaDB to be ready
until mysqladmin ping -h"$DB_HOST" --silent; do
    echo "Waiting for database..."
    sleep 2
done

# Download WordPress
wp core download --allow-root

# Create WordPress config
wp config create \
    --dbname=$DB_NAME \
    --dbuser=$DB_USER \
    --dbpass=$DB_PASSWORD \
    --dbhost=$DB_HOST \
    --allow-root \
    --skip-check

# Check if WordPress is already installed
if ! wp core is-installed --allow-root 2>/dev/null; then
    echo "Installing WordPress..."
    
    # Create database if it doesn't exist
    wp db create --allow-root 2>/dev/null || true
    
    # Install WordPress
    wp core install \
        --url=$HOST \
        --title="$WP_SITE_TITLE" \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASS \
        --admin_email=$WP_ADMIN_EMAIL \
        --allow-root
    
    echo "WordPress installed successfully!"
else
    echo "WordPress already installed, skipping..."
fi

# Start PHP-FPM
exec php-fpm7.4 -F