#!/bin/bash

set -e

# token for map repo
ghtoken=TOKEN

# move to home folder, container is server folder
cd /home/container
echo "Checking java version"
java -version

# avicus server repo
echo "Cloning server repo"
if [ -d /home/container/server ] && [ -f /home/container/server/server.properties ]; then
    echo "Server is already setup!"
else
	#rm -rf /home/container
	git clone https://github.com/alexanderjoe/avicus-server.git /home/container/server
fi

# clone maps or update maps
echo "Cloning and unpacking maps repo"
rm -rf /home/container/maps
mkdir /home/container/maps
curl -H "Authorization: token $ghtoken" -L https://api.github.com/repos/ProfessorUtonium/avicompmc/tarball | tar xz --strip-components=1 -C /home/container/server/maps
echo "Successfully unpacked maps"

# server dir
cd /home/container/server

# run server
sh run.sh
