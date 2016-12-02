#!/usr/bin/env bash

sudo service httpd stop
sudo service php71-php-fpm restart
sudo service nginx start

sudo setenfornce permissive

sudo ln -s /vagrant/src/* /var/www/html
sudo chmod 777 /vagrant/src/index.*
ab -n 10 -c 4 abtest.dev/index.php
