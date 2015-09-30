#!/bin/bash

echo '✩✩✩✩ Add Repositories ✩✩✩✩'
brew tap homebrew/dupes
brew tap josegonzalez/homebrew-php
brew update

echo '✩✩✩✩ Installing "dialog" to let you choose installation options ✩✩✩✩'
brew install dialog

OPTIONS=(
  1 "5.3"
  2 "5.4"
  3 "5.5"
  4 "5.6"
  5 "7.0"
)

CHOICE=$(dialog --clear \
                --backtitle "(E)nginx + MySQL + PHP Installer" \
                --title "PHP version" \
                --menu "Which version of PHP do you wish to install?" \
                12 50 5 \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
clear

case $CHOICE in
  "1")
    PHP_VERSION='53'
    PHP_VERSION_WITH_DOT='5.3' ;;
  "2")
    PHP_VERSION='54'
    PHP_VERSION_WITH_DOT='5.4' ;;
  "3")
    PHP_VERSION='55'
    PHP_VERSION_WITH_DOT='5.5' ;;
  "4")
    PHP_VERSION='56'
    PHP_VERSION_WITH_DOT='5.6' ;;
  "5")
    PHP_VERSION='70'
    PHP_VERSION_WITH_DOT='7.0' ;;
esac

echo '✩✩✩✩ MYSQL (mariadb) ✩✩✩✩'
brew install mariadb
#mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mariadb)" --datadir=/usr/local/var/mysql --tmpdir=/tmp

echo '✩✩✩✩ NGINX ✩✩✩✩'
brew install --with-passenger nginx

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
brew install php${PHP_VERSION} --without-apache --with-mysql --with-fpm --without-snmp
brew link --overwrite php${PHP_VERSION}

echo '✩✩✩✩ Memcached ✩✩✩✩'
brew install php${PHP_VERSION}-memcached

echo '✩✩✩✩ Redis ✩✩✩✩'
brew install redis php${PHP_VERSION}-redis

echo '✩✩✩✩ Solr ✩✩✩✩'
brew install solr

echo '✩✩✩✩ Xdebug ✩✩✩✩'
brew install php${PHP_VERSION}-xdebug

echo 'xdebug.remote_enable=On' >>  /usr/local/etc/php/${PHP_VERSION_WITH_DOT}/conf.d/ext-xdebug.ini
echo 'xdebug.remote_host="localhost"' >>  /usr/local/etc/php/${PHP_VERSION_WITH_DOT}/conf.d/ext-xdebug.ini
echo 'xdebug.remote_port=9002' >>  /usr/local/etc/php/${PHP_VERSION_WITH_DOT}/conf.d/ext-xdebug.ini
echo 'xdebug.remote_handler="dbgp"' >>  /usr/local/etc/php/${PHP_VERSION_WITH_DOT}/conf.d/ext-xdebug.ini

echo '✩✩✩✩ Xhprof ✩✩✩✩'
brew install graphviz php${PHP_VERSION}-xhprof
mkdir /tmp/xhprof
chmod 777 /tmp/xhprof
echo 'xhprof.output_dir=/tmp/xhprof' >>  /usr/local/etc/php/${PHP_VERSION_WITH_DOT}/conf.d/ext-xhprof.ini

curl -Lo /usr/local/etc/nginx/sites-available/xhprof.local https://raw.github.com/mrded/brew-emp/master/conf/nginx/sites-available/xhprof.local
ln -s /usr/local/etc/nginx/sites-available/xhprof.local /usr/local/etc/nginx/sites-enabled/xhprof.local
sudo echo '127.0.0.1 xhprof.local' >>  /etc/hosts

echo '✩✩✩✩ Drush ✩✩✩✩'
brew install drush

echo '✩✩✩✩ Brew-emp ✩✩✩✩'
curl -Lo /usr/local/bin/brew-emp https://raw.github.com/mrded/brew-emp/master/bin/brew-emp
chmod 755 /usr/local/bin/brew-emp
