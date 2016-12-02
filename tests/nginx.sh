#!/usr/bin/env bash

cp /etc/opt/remi/php71/php-fpm.d/www.conf.nginx /etc/opt/remi/php71/php-fpm.d/www.conf
sudo service httpd stop
sudo service php71-php-fpm restart
sudo service nginx start

#sudo setenforce permissive

sudo chmod 777 /vagrant/src/index.*

LOGDIR=/vagrant/tests/logs
ab -n 1 -c 4 abtest.dev/index.php > ${LOGDIR}/nginx-n1-c4.log
ab -n 4 -c 2 abtest.dev/index.php > ${LOGDIR}/nginx-n4-c2.log
ab -n 4 -c 4 abtest.dev/index.php > ${LOGDIR}/nginx-n4-c4.log
ab -n 10 -c 4 abtest.dev/index.php > ${LOGDIR}/nginx-n10-c4.log
ab -n 20 -c 8 abtest.dev/index.php > ${LOGDIR}/nginx-n20-c8.log
ab -n 50 -c 10 abtest.dev/index.php > ${LOGDIR}/nginx-n50-c9.log
ab -n 100 -c 100 abtest.dev/index.php > ${LOGDIR}/nginx-n10-c4.log

