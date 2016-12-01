#!/usr/bin/env bash

sudo service nginx stop
sudo service httpd start

ln -s /vagrant/src/* /var/www/html

ab -n 100 -c 100 10.10.10.10/index.php
