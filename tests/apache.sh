#!/usr/bin/env bash

sudo service nginx stop
sudo service php71-php-fpm restart
sudo service httpd start

#sudo setenfornce permissive

sudo chmod 777 /vagrant/src/index.*
ab -n 10 -c 4 abtest.dev/index.php
