#!/bin/bash
brew-emp stop

echo '✩✩✩✩ Uninstall php ✩✩✩✩'

PHP_VERSIONS=( 53 54 55 56 )
for PHP_VERSION in "${PHP_VERSIONS[@]}"
do
  brew remove php"$PHP_VERSION"
  brew remove php"$PHP_VERSION"-memcached
  brew remove php"$PHP_VERSION"-redis
  brew remove php"$PHP_VERSION"-xdebug
  brew remove php"$PHP_VERSION"-xhprof
done

curl -L https://raw.github.com/mrded/brew-emp/master/tools/install.sh | bash
