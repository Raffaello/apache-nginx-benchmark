#!/usr/bin/env bash

cp /etc/opt/remi/php71/php-fpm.d/www.conf.nginx /etc/opt/remi/php71/php-fpm.d/www.conf
sudo service nginx stop
sudo service php71-php-fpm restart
sudo service httpd start

#sudo setenfornce permissive

sudo chmod 777 /vagrant/src/index.*
ab -n 10 -c 4 abtest.dev/index.php
