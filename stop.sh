#!/bin/bash
mysql.server stop
sudo nginx -s stop
sudo pkill php-fpm
