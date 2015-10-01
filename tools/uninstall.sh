#!/bin/bash
brew-emp stop

brew remove mariadb
brew remove nginx

brew remove freetype
brew remove jpeg
brew remove libpng
brew remove gd
brew remove graphviz
brew remove drush

PHP_VERSIONS=( 53 54 55 56 )
for PHP_VERSION in "${PHP_VERSIONS[@]}"
do
  brew remove php"$PHP_VERSION"
  brew remove php"$PHP_VERSION"-memcached
  brew remove php"$PHP_VERSION"-redis
  brew remove php"$PHP_VERSION"-xdebug
  brew remove php"$PHP_VERSION"-xhprof
done

rm /usr/local/bin/brew-emp

echo "Done!"
