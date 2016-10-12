
#!/bin/bash

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt-get update -y
sudo apt-get install mongodb-org -y
#sudo apt-get install -y mongodb-org=3.2.9 mongodb-org-shell=3.2.9 mongodb-org-mongos=3.2.9 mongodb-org-tools=3.2.9
sudo cp ~/servers/database/mongodb.service /etc/systemd/system/mongodb.service
sudo cp ~/servers/database/mongod.conf /etc/mongod.conf
#sudo systemctl unmask mongodb
#sudo systemctl start mongodb
#sudo systemctl enable mongodb-org
sudo service mongod start
sudo iptables -A INPUT -s 192.10.10.100,192.10.10.150 -p tcp --destination-port 27017 -m state --state NEW,ESTABLISHED -j ACCEPT
