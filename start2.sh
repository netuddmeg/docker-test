#!/bin/bash

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin";
DMURL="https://github.com/docker/machine/releases/download/v0.15.0";
DCURL="https://github.com/docker/compose/releases/download/1.22.0"
REPODIR="my_first_docker_prod";
DOCKERMACHINE="docker-sandbox-swarm";
REPO="https://github.com/netuddmeg/my_first_docker_prod.git";
PROJECTNAME="my_first_docker_project";
DPATH="/usr/local/bin/";

export DEBIAN_FRONTEND=noninteractive && sudo apt install \
	apt-transport-https \
	ca-certificates \
	curl \
	software-properties-common;

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && \
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
	sudo apt-get update && sudo apt-get install docker-ce -y;

if [ ! -f "/usr/local/bin/docker-machine"  ] ; then
        sudo curl -L $DMURL/docker-machine-$(uname -s)-$(uname -m) > /tmp/docker-machine && sudo cp /tmp/docker-machine $DPATH/docker-machine && sudo chmod +x $DPATH/docker-machine;
fi;

if [ ! -f "/usr/local/bin/docker-compose"  ] ; then
	sudo curl -L $DCURL/docker-compose-$(uname -s)-$(uname -m) > /tmp/docker-compose && sudo cp /tmp/docker-compose $DPATH/docker-compose && sudo chmod +x $DPATH/docker-compose;
fi;


        	echo -n "Please, enter your token here [ENTER]: ";
	        read token;
	        DOTOKEN=$token;
		docker-machine create --driver digitalocean --digitalocean-access-token $DOTOKEN $DOCKERMACHINE;

		docker-machine ssh $DOCKERMACHINE "export DEBIAN_FRONTEND=noninteractive && sudo apt-get install git -y";
#		docker-machine ssh $DOCKERMACHINE "curl -L $DMURL/docker-machine-$(uname -s)-$(uname -m) > $DPATH/docker-machine && chmod +x $DPATH/docker-machine";
		eval $(docker-machine env $DOCKERMACHINE);

#		if [ ! -f "/usr/local/bin/docker-compose" ] ; then
#			docker-machine ssh $DOCKERMACHINE "curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m) > $DPATH/docker-compose;sudo chmod +x $DPATH/docker-compose";
#		fi;

#		git clone $REPO;
		cd $REPODIR; git pull; docker-compose up --build;


