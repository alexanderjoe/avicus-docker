#!/bin/bash

set -e

ghtoken=add later

cd /home/container
java -version

# clone default server files
git clone https://github.com/alexanderjoe/avicus-server.git ./server

# clone maps repo
mkdir server/maps
curl -H "Authorization: token $ghtoken" -L https://api.github.com/repos/ProfessorUtonium/avicompmc/tarball | tar xz --strip-components=1 -C server/maps

sh server/run.sh
