#!/bin/bash

echo '✩✩✩✩ MYSQL ✩✩✩✩'
brew install mysql
mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp

echo '✩✩✩✩ NGINX ✩✩✩✩'
brew install nginx

echo '✩✩✩✩ PHP + FPM ✩✩✩✩'
brew tap homebrew/dupes
brew tap josegonzalez/homebrew-php

brew install freetype jpeg libpng gd
brew install php53 --without-apache --with-mysql --with-fpm
