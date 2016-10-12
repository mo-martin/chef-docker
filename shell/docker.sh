# Disable firewalld
sudo ufw disable

# install docker
sudo apt-get update
sudo apt-get install -y curl
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update
apt-cache policy docker-engine
sudo apt-get install -y docker-engine
sudo service docker start
# Docker compose
sudo curl -L https://github.com/docker/compose/releases/download/1.8.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
ls -la /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
sudo chown -R vagrant:docker /usr/local/bin/docker-compose
ls -la /usr/local/bin/docker-compose
# groups
groupadd docker
sudo usermod -aG docker vagrant
# files to be copied
sudo cp -f /home/vagrant/synced/shell/files/chef/zero.rb /home/vagrant/cd-nginx/chef/zero.rb
sudo cp -f /home/vagrant/synced/shell/files/chef/first-boot.json /home/vagrant/cd-nginx/chef/first-boot.json
sudo cp -f /home/vagrant/synced/shell/files/chef/Dockerfile /home/vagrant/cd-nginx/chef/Dockerfile
sudo cp -f /home/vagrant/synced/shell/files/Berksfile /home/vagrant/cd-nginx/Berksfile
sudo cp -f /home/vagrant/synced/shell/files/Dockerfile /home/vagrant/cd-nginx/Dockerfile
sudo cp -f /home/vagrant/synced/shell/files/startup.sh /home/vagrant/cd-nginx/startup.sh
sudo cp -f /home/vagrant/synced/shell/files/docker-compose.yml /home/vagrant/cd-nginx/docker-compose.yml
sudo cp -f
# file permissions
sudo chown -R vagrant:docker /home/vagrant/cd-nginx
sudo chmod -R 777 /home/vagrant/cd-nginx
# chef install
sudo apt-get update
sudo apt-get install -y python-pip
curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk -c stable -v 0.16.28

sudo mkdir -p /home/vagrant/cd-nginx/chef/site-cookbooks
# Berksfile
pushd /home/vagrant/cd-nginx
berks install
berks vendor chef/cookbooks
sudo chmod 777 Berksfile.lock
popd
