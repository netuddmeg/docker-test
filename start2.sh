#!/bin/bash

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin";
DMURL="https://github.com/docker/machine/releases/download/v0.15.0";
DCURL="https://github.com/docker/compose/releases/download/1.22.0"
REPODIR="docker-test";
DOCKERMACHINE="docker-sandbox";
REPO="https://github.com/netuddmeg/docker-test.git";
PROJECTNAME="docker-test";
DPATH="/usr/local/bin/";

# installing some stuff
export DEBIAN_FRONTEND=noninteractive && sudo apt install -y \
	apt-transport-https \
	ca-certificates \
	git \
	curl \
	software-properties-common;

# if docker(-ce) does not exist, install!
if [ ! -d "/usr/share/docker-ce"  ] ; then
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
	sudo apt-get update && sudo apt-get install docker-ce -y;
fi;

# if docker-machine does not exist, install!
if [ ! -f "/usr/local/bin/docker-machine"  ] ; then
	sudo curl -L $DMURL/docker-machine-$(uname -s)-$(uname -m) > /tmp/docker-machine && sudo cp /tmp/docker-machine $DPATH/docker-machine && sudo chmod +x $DPATH/docker-machine;
fi;

# if docker-compose does not exist, install!
if [ ! -f "/usr/local/bin/docker-compose"  ] ; then
	sudo curl -L $DCURL/docker-compose-$(uname -s)-$(uname -m) > /tmp/docker-compose && sudo cp /tmp/docker-compose $DPATH/docker-compose && sudo chmod +x $DPATH/docker-compose;
fi;

			#token must be entered in case of DigitalOcean provider
        	echo -n "Please, enter your token here [ENTER]: ";
	        read token;

	        	if [ -z "$token" ]; then
	        		echo "You have must enter your token!";
	        		exit 1;
	        	fi;

	        DOTOKEN=$token;
# create a VPS in the provider
docker-machine create --driver digitalocean --digitalocean-access-token $DOTOKEN $DOCKERMACHINE;

#install some stuff on the VPS
docker-machine ssh $DOCKERMACHINE "export DEBIAN_FRONTEND=noninteractive && \
								sudo apt-get install -y \
								git;"
										

# set environment
eval $(docker-machine env $DOCKERMACHINE);

#finally clone the repo and build&up
git clone $REPO;
cd $REPODIR; git pull; docker-compose up -d --build;

echo "Your VPS's IP address is: `docker-machine ip docker-sandbox`"


