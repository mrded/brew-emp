# Homebrew (E)Nginx MySQL PHP Installer

Native way to setup web environment for Mac.

![brew-emp](brew-emp.png)

## Overview

This script will install and setup **Nginx** + **MySQL** + **PHP** through **Homebrew**.

## Requirements

* [Homebrew](http://mxcl.github.com/homebrew/)
* Snow Leopard, Lion, Mountain Lion. Untested everywhere else
 
## Installation
Choose one and paste that at a Terminal prompt:

### PHP52
  
    curl -L https://raw.github.com/mrded/brew-emp/master/install.sh php52 | bash
    
### PHP53
  
    curl -L https://raw.github.com/mrded/brew-emp/master/install.sh php53 | bash
    
### PHP54
  
    curl -L https://raw.github.com/mrded/brew-emp/master/install.sh php54 | bash

## Usage
`brew-emp [start | stop | restart]`

## Creating VirtualHost
For example let's create virtual host for Drupal 'mysite'.

Copy Drupal preset:
`cp /usr/local/etc/nginx/sites-available/drupal.local /usr/local/etc/nginx/sites-available/mysite.local`
    
Change name and path to site: 
`vim /usr/local/etc/nginx/sites-available/mysite.local`
    
    
    server {
      listen       80;
      server_name  mysite.local;
      root /Users/mrded/Sites/mysite;

      access_log /usr/local/var/log/nginx/mysite.access.log;
      error_log  /usr/local/var/log/nginx/mysite.error.log;

      include /usr/local/etc/nginx/common/drupal;
    }

Enable virtual host:
`ln -s /usr/local/etc/nginx/sites-available/mysite.local /usr/local/etc/nginx/sites-enabled/mysite.local`

Add `127.0.0.1 mysite.local` to `/etc/hosts`.

## Default Settings

### MySQL
Username: root

Password:

Port: 3306

### Xdebug
Remote port is 9002

## Configs

**Nginx**: `/usr/local/etc/nginx/nginx.conf`

**FastCGI**: `/usr/local/etc/nginx/fastcgi.conf`

**PHP**: `/usr/local/etc/php/5.3/php.ini`

**Redis**: `/usr/local/etc/redis.conf`

**Xdebug**: `/usr/local/etc/php/5.3/conf.d/ext-xdebug.ini`

**MySQL**: `$(brew --prefix mysql)/my.cnf`
