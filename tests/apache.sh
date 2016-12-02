#!/usr/bin/env bash

sudo cp /etc/opt/remi/php71/php-fpm.d/www.conf.nginx /etc/opt/remi/php71/php-fpm.d/www.conf
sudo service nginx stop
sudo service php71-php-fpm restart
sudo service httpd start

sudo setenforce permissive

sudo chmod 777 /vagrant/src/index.*

LOGDIR=/vagrant/tests/logs
ab -n 1 abtest.dev/index.php > ${LOGDIR}/httpd-n1.log
ab -n 4 -c 2 abtest.dev/index.php > ${LOGDIR}/httpd-n4-c2.log
ab -n 4 -c 4 abtest.dev/index.php > ${LOGDIR}/httpd-n4-c4.log
ab -n 10 -c 4 abtest.dev/index.php > ${LOGDIR}/httpd-n10-c4.log
ab -n 20 -c 8 abtest.dev/index.php > ${LOGDIR}/httpd-n20-c8.log
ab -n 50 -c 10 abtest.dev/index.php > ${LOGDIR}/httpd-n50-c10.log
ab -n 100 -c 100 abtest.dev/index.php > ${LOGDIR}/nginx-n100-c100.log
ab -n 1000 -c 100 abtest.dev/index.php > ${LOGDIR}/nginx-n1000-c100.log
ab -n 10000 -c 100 abtest.dev/index.php > ${LOGDIR}/nginx-n10000-c100.log
ab -n 10000 -c 1000 abtest.dev/index.php > ${LOGDIR}/nginx-n10000-c1000.log
