#!/usr/bin/env bash

echo -n "starting test..."
cd /vagrant/tests
#LOGDIR=/vagrant/tests/logs
echo -n "."
ab -e logs/httpd-n1.log.csv -n 1 abtest.dev/index.php > logs/httpd-n1.log
echo -n "."
ab -e logs/httpd-n4-c2.log.csv -n 4 -c 2 abtest.dev/index.php > logs/httpd-n4-c2.log
echo -n "."
ab -e logs/httpd-n4-c4.log.csv -n 4 -c 4 abtest.dev/index.php > logs/httpd-n4-c4.log
echo -n "."
ab -e logs/httpd-n10-c4.log.csv -n 10 -c 4 abtest.dev/index.php > logs/httpd-n10-c4.log
echo -n "."
ab -e logs/httpd-n20-c8.log.csv -n 20 -c 8 abtest.dev/index.php > logs/httpd-n20-c8.log
echo -n "."
ab -e logs/httpd-n50-c10.log.csv -n 50 -c 10 abtest.dev/index.php > logs/httpd-n50-c10.log
echo -n "."
ab -e logs/httpd-n100-c100.log.csv -n 100 -c 100 abtest.dev/index.php > logs/nginx-n100-c100.log
echo -n "."
ab -e logs/httpd-n1000-c100.log.csv -n 1000 -c 100 abtest.dev/index.php > logs/nginx-n1000-c100.log
echo -n "."
ab -e logs/httpd-n10000-c100.log.csv -n 10000 -c 100 abtest.dev/index.php > logs/nginx-n10000-c100.log
echo -n "."
ab -e logs/httpd-n10000-c1000.log.csv -n 10000 -c 1000 abtest.dev/index.php > logs/nginx-n10000-c1000.log
echo -n "."
ab -e logs/httpd-n100000-c1000.log.csv -n 100000 -c 1000 abtest.dev/index.php > logs/nginx-n100000-c1000.log
echo "OK!"