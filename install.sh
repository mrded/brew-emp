#!/bin/bash
brew tap homebrew/dupes
brew update

echo '✩✩✩✩ MYSQL ✩✩✩✩'
brew install mysql
mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp

echo '✩✩✩✩ NGINX ✩✩✩✩'
brew install nginx

echo '-> Download configs'
mkdir /usr/local/etc/nginx/{common,sites-available,sites-enabled}

curl -o /usr/local/etc/nginx/nginx.conf https://raw.github.com/mrded/brew-emp/master/conf/nginx/nginx.conf

curl -o /usr/local/etc/nginx/common/php https://raw.github.com/mrded/brew-emp/master/conf/nginx/common/php
curl -o /usr/local/etc/nginx/common/drupal https://raw.github.com/mrded/brew-emp/master/conf/nginx/common/drupal

# Download Virtual Hosts.
curl -o /usr/local/etc/nginx/sites-available/default https://raw.github.com/mrded/brew-emp/master/conf/nginx/sites-available/default
curl -o /usr/local/etc/nginx/sites-available/drupal.local https://raw.github.com/mrded/brew-emp/master/conf/nginx/sites-available/drupal.local

ln -s /usr/local/etc/nginx/sites-available/default /usr/local/etc/nginx/sites-enabled/default

# Create folder for logs.
mkdir -p /usr/local/var/log/{fpm,nginx}

echo '✩✩✩✩ PHP + FPM ✩✩✩✩'
brew tap homebrew/dupes
brew tap josegonzalez/homebrew-php

brew install freetype jpeg libpng gd
brew install php53 --without-apache --with-mysql --with-fpm

echo '✩✩✩✩ Memcached ✩✩✩✩'
brew install php53-memcached

echo '✩✩✩✩ Xdebug ✩✩✩✩'
brew install php53-xdebug

echo 'xdebug.remote_enable=On' >>  /usr/local/etc/php/5.3/conf.d/ext-xdebug.ini
echo 'xdebug.remote_host="localhost"' >>  /usr/local/etc/php/5.3/conf.d/ext-xdebug.ini
echo 'xdebug.remote_port=9002' >>  /usr/local/etc/php/5.3/conf.d/ext-xdebug.ini
echo 'xdebug.remote_handler="dbgp"' >>  /usr/local/etc/php/5.3/conf.d/ext-xdebug.ini

echo '✩✩✩✩ Drush ✩✩✩✩'
brew install drush

echo '✩✩✩✩ Brew-emp ✩✩✩✩'
curl -o /usr/local/bin/brew-emp https://raw.github.com/mrded/brew-emp/master/bin/brew-emp
chmod 755 /usr/local/bin/brew-emp
