#!/bin/bash

case "$1" in
"php52")
  PHP_VERSION='52' ;;
"php53")
  PHP_VERSION='53' ;;
"php54")
  PHP_VERSION='54' ;;
"php55")
  PHP_VERSION='55' ;;
*)
  PHP_VERSION='55' ;;
esac

echo "Your choice is PHP${PHP_VERSION}!"
echo "----- ✄ -----------------------"

echo '✩✩✩✩ Add Repositories ✩✩✩✩'
brew tap homebrew/dupes
brew tap josegonzalez/homebrew-php
brew update

echo '✩✩✩✩ MYSQL ✩✩✩✩'
brew install mysql
mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp

echo '✩✩✩✩ NGINX ✩✩✩✩'
brew install nginx

echo '-> Download configs'
mkdir /usr/local/etc/nginx/{common,sites-available,sites-enabled}

curl -Lo /usr/local/etc/nginx/nginx.conf https://raw.github.com/mrded/brew-emp/master/conf/nginx/nginx.conf

curl -Lo /usr/local/etc/nginx/common/php https://raw.github.com/mrded/brew-emp/master/conf/nginx/common/php
curl -Lo /usr/local/etc/nginx/common/drupal https://raw.github.com/mrded/brew-emp/master/conf/nginx/common/drupal

# Download Virtual Hosts.
curl -Lo /usr/local/etc/nginx/sites-available/default https://raw.github.com/mrded/brew-emp/master/conf/nginx/sites-available/default
curl -Lo /usr/local/etc/nginx/sites-available/drupal.local https://raw.github.com/mrded/brew-emp/master/conf/nginx/sites-available/drupal.local

ln -s /usr/local/etc/nginx/sites-available/default /usr/local/etc/nginx/sites-enabled/default

# Create folder for logs.
rm -rf /usr/local/var/log/{fpm,nginx}
mkdir -p /usr/local/var/log/{fpm,nginx}

echo '✩✩✩✩ PHP + FPM ✩✩✩✩'
brew install freetype jpeg libpng gd
brew install php${PHP_VERSION} --without-apache --with-mysql --with-fpm
brew link --overwrite php${PHP_VERSION}

echo '✩✩✩✩ Memcached ✩✩✩✩'
brew install php${PHP_VERSION}-memcached

echo '✩✩✩✩ Redis ✩✩✩✩'
brew install redis php${PHP_VERSION}-redis

echo '✩✩✩✩ Solr ✩✩✩✩'
brew install solr

echo '✩✩✩✩ Xdebug ✩✩✩✩'
brew install php${PHP_VERSION}-xdebug

case "${PHP_VERSION}" in
"52")
  DOT_VERSION='5.2' ;;
"53")
  DOT_VERSION='5.3' ;;
"54")
  DOT_VERSION='5.4' ;;
"55")
  DOT_VERSION='5.5' ;;
esac

echo 'xdebug.remote_enable=On' >>  /usr/local/etc/php/${DOT_VERSION}/conf.d/ext-xdebug.ini
echo 'xdebug.remote_host="localhost"' >>  /usr/local/etc/php/${DOT_VERSION}/conf.d/ext-xdebug.ini
echo 'xdebug.remote_port=9002' >>  /usr/local/etc/php/${DOT_VERSION}/conf.d/ext-xdebug.ini
echo 'xdebug.remote_handler="dbgp"' >>  /usr/local/etc/php/${DOT_VERSION}/conf.d/ext-xdebug.ini

echo '✩✩✩✩ Drush ✩✩✩✩'
brew install drush

echo '✩✩✩✩ Brew-emp ✩✩✩✩'
curl -Lo /usr/local/bin/brew-emp https://raw.github.com/mrded/brew-emp/master/bin/brew-emp
chmod 755 /usr/local/bin/brew-emp
