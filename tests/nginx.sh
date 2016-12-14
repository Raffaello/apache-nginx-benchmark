#!/usr/bin/env bash

sudo setenforce permissive;
sudo service httpd stop || exit 1;
sudo service php71-php-fpm stop || exit 1;

sudo cp /etc/opt/remi/php71/php-fpm.d/www.conf.nginx /etc/opt/remi/php71/php-fpm.d/www.conf || exit 1;
sleep 3

sudo service php71-php-fpm start || exit 1;
sudo service nginx start || exit 1;

#sudo chmod 777 /vagrant/src/index.*
#sudo ./abtests.sh
./test_report.r nginx
