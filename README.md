# Homebrew (E)Nginx MySQL PHP Installer

This script will install and setup Nginx + MySQL + PHP through Homebrew.

## Requirements

* Homebrew
* Snow Leopard, Lion, Mountain Lion. Untested everywhere else
* The homebrew `dupes` tap - `brew tap homebrew/dupes`
 
## Installation
  
    ./install.sh

## Usage

To start: `./start.sh`

To stop: `./stop.sh`

## Configs

### Nginx
`/usr/local/etc/nginx/nginx.conf`

### FastCGI
`/usr/local/etc/nginx/fastcgi.conf`

### PHP
`/usr/local/etc/php/5.3/php.ini`

### MySQL
`/usr/local/opt/mysql/my.cnf`
