#!/bin/bash
mysql.server start
sudo nginx
sudo /usr/local/sbin/php-fpm&
