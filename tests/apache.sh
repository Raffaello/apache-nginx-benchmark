#!/usr/bin/env bash

sudo setenforce permissive;
sudo service nginx stop || exit 1;
sudo service php71-php-fpm stop || exit 1;

sudo cp /etc/opt/remi/php71/php-fpm.d/www.conf.httpd /etc/opt/remi/php71/php-fpm.d/www.conf || exit 1;
sleep 3

sudo service php71-php-fpm start || exit 1;
sudo service httpd start || exit 1;

#sudo chmod 777 /vagrant/src/index.*
#sudo ./abtests.sh
sudo ./test_report.r httpd abtest.dev/index.php
