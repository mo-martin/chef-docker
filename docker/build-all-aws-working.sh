#!/bin/bash

set +e
docker stop moses-app
docker rm moses-app
docker stop moses-api
docker rm moses-api
docker stop moses-db
docker rm moses-db
find ~/scripts/docker/my-node-api/api/* -type d -not -name '.gitignore' -print0 | xargs -0 rm -rf --
find ~/scripts/docker/my-node-app/app/* -type d -not -name '.gitignore' -print0 | xargs -0 rm -rf --
find ~/scripts/docker/my-node-db/db/* -type d -not -name '.gitignore' -print0 | xargs -0 rm -rf --
set -e

rm -rf ~/pokergame/tmp/node-api/api
rm -rf ~/pokergame/tmp/node-app/app
rm -rf ~/pokergame/tmp/node-db/db
mkdir -p ~/pokergame/tmp/node-app/app
mkdir -p ~/pokergame/tmp/node-api/api
mkdir -p ~/pokergame/tmp/node-db/db

cp -r ~/pokergame/app/. ~/pokergame/tmp/node-app/app/
cp -r ~/pokergame/api/. ~/pokergame/tmp/node-api/api/
cp -r ~/scripts/database/. ~/pokergame/tmp/node-db/db/
rm -rf ~/pokergame/tmp/node-app/app/.git
rm -rf ~/pokergame/tmp/node-app/app/.gitignore
rm -rf ~/pokergame/tmp/node-api/api/.git
rm -rf ~/pokergame/tmp/node-api/api/.gitignore

cp -r ~/pokergame/tmp/node-app/app/. ~/scripts/docker/my-node-app/app/
cp -r ~/pokergame/tmp/node-api/api/. ~/scripts/docker/my-node-api/api/
cp -r ~/pokergame/tmp/node-db/db/. ~/scripts/docker/my-node-db/db/


pushd my-node-app
docker build --tag my-node-app:latest .
popd
pushd my-node-api
docker build --tag my-node-api:latest .
popd
pushd my-node-db
docker build --tag my-node-db:latest .
popd
pushd my-node-data
docker build --tag my-node-data:latest .
popd

# node data
echo -e "\033[0;31mChecking for my-node-data \033[0m"
set +e
docker ps -a | grep my-node-data > /dev/null
FOUND_MONGO=$?
set -e

if [[ "$FOUND_MONGO" == "0" ]]; then
 echo -e "\033[0;node data store already exists\033[0m"
else
 echo -e "\033[1;33mRunning data container\033[0m"
 docker create --name my-node-data my-node-data:latest
fi

docker run --name moses-db --volumes-from my-node-data -d my-node-db:latest
docker run --name moses-api -p 3001:3001 --link moses-db:db -e DB_URL=mongodb://db/Poker -d my-node-api:latest
docker run --name moses-app -p 3000:3000 --link moses-api:api -e API_URL=http://ec2-52-18-216-199.eu-west-1.compute.amazonaws.com:3001 -d my-node-app:latest
docker ps -a
