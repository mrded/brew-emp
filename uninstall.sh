#!/bin/bash
brew remove mariadb
brew remove nginx

brew remove freetype
brew remove jpeg
brew remove libpng
brew remove gd
brew remove drush

brew remove php53
brew remove php54
brew remove php55
brew remove php56

brew remove php53-memcached
brew remove php54-memcached
brew remove php55-memcached
brew remove php56-memcached

brew remove php53-redis
brew remove php54-redis
brew remove php55-redis
brew remove php56-redis

brew remove php53-xdebug
brew remove php54-xdebug
brew remove php55-xdebug
brew remove php56-xdebug

brew remove php53-xhprof
brew remove php54-xhprof
brew remove php55-xhprof
brew remove php56-xhprof

rm /usr/local/bin/brew-emp

echo "Done!"
