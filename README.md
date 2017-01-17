# Apache <=> NGINX benchmark

## Requirements

- Vagrant
- NFS
- Vagrant reload plugin `vagrant plugin install vagrant-reload`

## usage

- `vagrant ssh`
- `cd apache-nginx-benchmark\tests`
- `./nginx.sh; ./apache.sh`
- `./generate_report.r`

The VM probably will crash with apache and it will not be able to finish the test, still need to fix a minor configuration for load testing. 

