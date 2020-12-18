#!/bin/bash

set -e

# token for map repo
ghtoken=TOKEN

# working dir
cd /home/container
echo "Checking java version"
java -version

# avicus server repo
echo "Cloning server repo"
git clone https://github.com/alexanderjoe/avicus-server.git ./server

# clone maps
echo "Cloning and unpacking maps repo"
mkdir server/maps
curl -H "Authorization: token $ghtoken" -L https://api.github.com/repos/ProfessorUtonium/avicompmc/tarball | tar xz --strip-components=1 -C server/maps

echo "Successfully unpacked maps"

# server dir
cd server

# run server
sh run.sh
