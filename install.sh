#!/bin/bash

echo '✩✩✩✩ MYSQL ✩✩✩✩'
brew install mysql
mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp

echo '✩✩✩✩ NGINX ✩✩✩✩'
brew install nginx

# @TODO: Download nginx.conf to /usr/local/etc/nginx/nginx.conf

mkdir /usr/local/etc/nginx/{common,sites-available,sites-enabled}
# @TODO: Download drupal to /usr/local/etc/nginx/common/drupal

# @TODO: Download default to /usr/local/etc/nginx/sites-available/default 
ln -s /usr/local/etc/nginx/sites-available/default /usr/local/etc/nginx/sites-enabled/default

# Create folder for logs.
mkdir -p /usr/local/var/log/{fpm,nginx}

echo '✩✩✩✩ PHP + FPM ✩✩✩✩'
brew tap homebrew/dupes
brew tap josegonzalez/homebrew-php

brew install freetype jpeg libpng gd
brew install php53 --without-apache --with-mysql --with-fpm

echo '✩✩✩✩ Drush ✩✩✩✩'
brew install drush

