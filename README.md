# Apache <=> NGINX benchmark

## Requirements

- Vagrant
- NFS
- Vagrant reload plugin `vagrant plugin install vagrant-reload`

## Config

The NGINX and Apache configuration are matched as much as possible, so to have a balanced comparison.

One penalty on Apache is the CentOS version is not able to use Unix Sockets.


#### PHP 7.1

- default configuration

#### PHP-FPM

- `max_children = 1000`

#### Apache

- using module `mpm_event` with params: 
    - `StartServers          1`
    - `MaxRequestWorkers     2560`
- using FastCGI with TCP port (due to version not supporting using socket, performance penalty)
- disable the other not required modules (`cgi`, `lua`) 


#### NGINX

- Almost out-of-the-box configuration
- FastCGI with Unix Socket
- Worker connections rose up to 5120

## Usage

- `vagrant up`
- `vagrant ssh`
- `cd apache-nginx-benchmark\tests`
- `./nginx.sh; ./apache.sh`
- `./generate_report.r`

The VM it might crash with Apache and it will not be able to finish the tests, still need to fix a minor configuration for load testing. 

