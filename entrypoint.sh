#!/bin/bash

set -e
cd /

# pterodactyl compatibility
if [[ ! -z "${STARTUP}" ]]; then
    echo "Running pre-start startup..."
	eval "${STARTUP}"
	echo "Pre-start complete."
fi

# vars, import vars
if [[ -f "/home/container/env.sh" ]]; then
    source /home/container/env.sh
    echo "Imported environment variables"
fi
mapsrepo="ProfessorUtonium/avicompmc"
if [[ ! -z "${MAPS_REPO}" ]]; then
    mapsrepo="${MAPS_REPO}"
	echo "Detected alternative maps repository ${MAPS_REPO}"
fi

# avicus server repo
if [ -d /home/container/server ] && [ -f /home/container/server/server.properties ] && [[ -z "${RESET_SERVER}" ]]; then
    echo "Server is already setup, not redownloading!"
else
    echo "Cloning server repo"
	rm -rf /home/container/server
	mkdir -p /home/container/server
	git clone https://github.com/alexanderjoe/avicus-server.git /home/container/server
	echo "Server ready."
fi

if [[ -z "${MAP_NO_UPDATE}" ]]; then
    # clone maps or update maps
    echo "Cloning and unpacking maps repo"
    rm -rf /home/container/server/maps
    mkdir /home/container/server/maps
    if [[ ! -z "${TOKEN}" ]]; then
	    echo "Using authentication with GH"
    	curl -H "Authorization: token ${TOKEN}" -L https://api.github.com/repos/$mapsrepo/tarball | tar xz --strip-components=1 -C /home/container/server/maps/
    else
	    curl -L https://api.github.com/repos/"${mapsrepo}"/tarball | tar xz --strip-components=1 -C /home/container/server/maps/
    fi
    echo "Successfully unpacked maps"
else
    echo "Bypassing map update."
fi

# server dir - run
echo "Running:"
cd /home/container/server && java -version && /bin/bash run.sh
echo "Done."
