# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.define "docker" do |docker|
    docker.vm.box = "bento/ubuntu-16.04"
    docker.vm.hostname = "Docker"
    docker.vm.synced_folder "~/sparta/multi-vagrant-project/app", "/home/vagrant/synced/app"
    docker.vm.synced_folder "~/sparta/multi-vagrant-project/api", "/home/vagrant/synced/api"
    docker.vm.synced_folder "docker/", "/home/vagrant/synced/docker"
    docker.vm.synced_folder "shell/", "/home/vagrant/synced/shell"
    docker.vm.synced_folder "site-cookbooks/", "/home/vagrant/cd-nginx/chef/site-cookbooks"
    docker.vm.network "forwarded_port", guest:80, host:80
    docker.vm.network "forwarded_port", guest:443, host:443
    docker.vm.network "forwarded_port", guest:1080, host:1080
    docker.vm.network "forwarded_port", guest:1180, host:1180
    docker.vm.network "forwarded_port", guest:1443, host:1443
    docker.vm.network "forwarded_port", guest:8080, host:8080
    docker.vm.network "forwarded_port", guest:3000, host:3000
    docker.vm.network "forwarded_port", guest:3001, host:3001
    docker.vm.network "forwarded_port", guest:27017, host:27017
    docker.vm.provision "shell", path: "shell/docker.sh"
  end
  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
    v.name = "Docker"
end
end
