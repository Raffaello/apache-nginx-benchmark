# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.box_check_update = true
  config.vm.provider "virtualbox" do |vb|
     vb.memory = "1024"
     vb.cpu = 2
  end

  config.vm.synced_folder ".",
    "/home/vagrant/apache-nginx-benchmark",
    type: "nfs".vm.synced_folder ".",
    "/home/vagrant/apache-nginx-benchmark", type: "nfs"

  config.ssh.insert_key = false
  config.vm.hostname = "benchmark.dev"
  config.vm.network "private_netwrok", ip: "10.10.10.10"

  config.vm.provision "shell", inline: <<-SHELL
    yum -y upgrade
    sudo rpm -iUvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
    yum -y update
    sudo yum -y install ansible
  SHELL

  config.vm.provision "ansible_local" do |ansible|
    ansible.install  = false
    ansible.playbook = "ansible/playbook.yml"
    ansible.verbose  = true
  end
end
