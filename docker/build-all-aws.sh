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
