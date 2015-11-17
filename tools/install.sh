#!/bin/bash

echo '✩✩✩✩ Add Repositories ✩✩✩✩'
brew untap josegonzalez/homebrew-php
brew tap homebrew/dupes
brew tap homebrew/versions
brew tap homebrew/homebrew-php
brew update

echo '✩✩✩✩ Installing "dialog" to let you choose installation options ✩✩✩✩'
brew install dialog

BACKTITLE="(E)nginx + MySQL + PHP Installer"

PHP_VERSIONS=(
  1 "5.3"
  2 "5.4"
  3 "5.5"
  4 "5.6"
)

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "PHP version" \
                --menu "Which version of PHP do you wish to install?" \
                12 50 5 \
                "${PHP_VERSIONS[@]}" \
                2>&1 >/dev/tty)
clear

case $CHOICE in
  1)
    PHP_VERSION='53'
    PHP_VERSION_WITH_DOT='5.3'
    ;;
  2)
    PHP_VERSION='54'
    PHP_VERSION_WITH_DOT='5.4'
    ;;
  3)
    PHP_VERSION='55'
    PHP_VERSION_WITH_DOT='5.5'
    ;;
  4)
    PHP_VERSION='56'
    PHP_VERSION_WITH_DOT='5.6'
    ;;
esac

echo '✩✩✩✩ MYSQL ✩✩✩✩'
brew install mysql
#mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp
curl -Lo /usr/local/etc/my.cnf https://raw.github.com/mrded/brew-emp/master/conf/mysql/my.cnf
chmod 644 /usr/local/etc/my.cnf

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

AVAILABLE_PACKAGES=(
  1 "Memcached" off
  2 "Redis" on
  3 "Xdebug" on
  4 "Drush" on
)

PACKAGES=$(dialog --separate-output \
                  --backtitle "$BACKTITLE" \
                  --checklist "Additional packages to install:" \
                  12 50 4 \
                  "${AVAILABLE_PACKAGES[@]}" \
                  2>&1 >/dev/tty)
clear

for PACKAGE in $PACKAGES
do
  case $PACKAGE in
    1)
      echo '✩✩✩✩ Memcached ✩✩✩✩'
      brew install php${PHP_VERSION}-memcached
      ;;
    2)
      echo '✩✩✩✩ Redis ✩✩✩✩'
      brew install redis php${PHP_VERSION}-redis
      ;;
    3)
      echo '✩✩✩✩ Xdebug ✩✩✩✩'
      brew install php${PHP_VERSION}-xdebug

      echo 'xdebug.remote_enable=On' >>  /usr/local/etc/php/${PHP_VERSION_WITH_DOT}/conf.d/ext-xdebug.ini
      echo 'xdebug.remote_host="localhost"' >>  /usr/local/etc/php/${PHP_VERSION_WITH_DOT}/conf.d/ext-xdebug.ini
      echo 'xdebug.remote_port=9002' >>  /usr/local/etc/php/${PHP_VERSION_WITH_DOT}/conf.d/ext-xdebug.ini
      echo 'xdebug.remote_handler="dbgp"' >>  /usr/local/etc/php/${PHP_VERSION_WITH_DOT}/conf.d/ext-xdebug.ini
      ;;
    4)
      echo '✩✩✩✩ Drush ✩✩✩✩'
      brew install drush
      ;;
  esac
done

echo '✩✩✩✩ Brew-emp ✩✩✩✩'
curl -Lo /usr/local/bin/brew-emp https://raw.github.com/mrded/brew-emp/master/bin/brew-emp
chmod 755 /usr/local/bin/brew-emp
