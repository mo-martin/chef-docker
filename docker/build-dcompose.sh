#!/bin/bash
# eval "$(docker-machine env default)"

set +e
docker stop moses-app
docker rm moses-app
docker stop moses-api
docker rm moses-api
docker stop moses-db
docker rm moses-db
find ~/scripts/chef-docker/docker/my-node-api/api/* -type d -not -name '.gitignore' -print0 | xargs -0 rm -rf --
find ~/scripts/chef-docker/docker/my-node-app/app/* -type d -not -name '.gitignore' -print0 | xargs -0 rm -rf --
find ~/scripts/chef-docker/docker/my-node-db/db/* -type d -not -name '.gitignore' -print0 | xargs -0 rm -rf --
set -e

rm -rf /tmp/node-api/api
rm -rf /tmp/node-app/app
rm -rf /tmp/node-db/db
mkdir -p /tmp/node-app/app
mkdir -p /tmp/node-api/api
mkdir -p /tmp/node-db/db

cp -r ~/pokergame/app/. /tmp/node-app/app/
cp -r ~/pokergame/api/. /tmp/node-api/api/
cp -r ~/scripts/chef-docker/database/. /tmp/node-db/db/
rm -rf /tmp/node-app/app/.git
rm -rf /tmp/node-app/app/.gitignore
rm -rf /tmp/node-api/api/.git
rm -rf /tmp/node-api/api/.gitignore

cp -r /tmp/node-app/app/. ./my-node-app/app/
cp -r /tmp/node-api/api/. ./my-node-api/api/
cp -r /tmp/node-db/db/. ./my-node-db/db/
