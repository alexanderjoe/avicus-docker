#!/bin/bash

set -e

ghtoken=af70a68f311562fc50c88726fc309d6d859bd8da

cd /home/container
java -version

# clone default server files
git clone https://github.com/alexanderjoe/avicus-server.git ./server

# clone maps repo
mkdir server/maps
curl -H "Authorization: token $ghtoken" -L https://api.github.com/repos/ProfessorUtonium/avicompmc/tarball | tar xz --strip-components=1 -C server/maps

sh server/run.sh
