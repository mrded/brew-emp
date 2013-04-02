# Homebrew (E)Nginx MySQL PHP Installer

This script will install and setup Nginx + MySQL + PHP through Homebrew.

## Requirements

* [Homebrew](http://mxcl.github.com/homebrew/)
* Snow Leopard, Lion, Mountain Lion. Untested everywhere else
* The homebrew `dupes` tap - `brew tap homebrew/dupes`
 
## Installation
Paste that at a Terminal prompt:
  
    curl -0 https://raw.github.com/mrded/brew-emp/master/install.sh | bash

## Usage
`brew-emp [start | stop | restart]`

## Configs

### Nginx
`/usr/local/etc/nginx/nginx.conf`

### FastCGI
`/usr/local/etc/nginx/fastcgi.conf`

### PHP
`/usr/local/etc/php/5.3/php.ini`

### MySQL
`/usr/local/opt/mysql/my.cnf`
