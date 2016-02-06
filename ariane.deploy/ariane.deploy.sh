#!/bin/sh

sudo docker images | grep ariane.buildenv > /dev/null
if [ $? -ne 0 ]; then
	echo "You must build ariane.buildenv docker images first"
	exit 1
fi

dockerComposePath=`which docker-compose`
if [ $? -ne 0 ]; then
	echo "You must install docker-compose first"
	exit 1
fi

sysname=`uname -a` > /dev/null
echo $sysname | grep Linux > /dev/null
if [ $? -eq 0 ]; then
	nbCpu=`more /proc/cpuinfo | grep processor | wc -l`
	if [ "$nbCpu" -lt 4 ]; then
		echo "This system has ${nbCpu} CPUs. It is advised to not run this script if you have less than 4 CPUs."
		echo "Do you want to continue ? (Y|N - default)"
		read continue
		if [ "${read}" != "Y" ]; then
			exit 0
		fi
	fi
else
        echo "Ariane deployment tool is tested against Linux only"
	exit 1
fi

if [ $# -ne 2 ]; then
	echo "Usage: $0 [LOCAL ARIANE SOURCE DIRECTORY PATH] [VERSION]"
	exit 1
fi

ARIANE_HOME=$1
ARIANE_VERS=$2
ARIANE_VERS2=$2
if [ ${ARIANE_VERS} = "master" ]; then
	ARIANE_VERS2="master.SNAPSHOT"
fi

USER_GROUP_NAME=`groups|awk '{print $1}'`
echo "USER_GROUP_NAME=${USER_GROUP_NAME}" > ~/.ariane.buildenv.properties
echo "GID=`getent group ${USER_GROUP_NAME}|cut -d: -f3`" >> ~/.ariane.buildenv.properties
#echo "GID=${GID}" >> ~/.ariane.buildenv.properties
echo "" >> ~/.ariane.buildenv.properties

echo "USER_NAME=${USER}" >> ~/.ariane.buildenv.properties
echo "UID=`id -u $USER_NAME`" >> ~/.ariane.buildenv.properties

sudo docker run --rm --privileged=true -e ARIANE_DISTRIB_ARGS="distpkgr ${ARIANE_VERS2}" \
                -v $1:/ECHINOPSII:rw -v $HOME/.m2:$HOME/.m2:rw \
                -v $HOME/.ariane.buildenv.properties:/ariane.buildenv.properties \
                echinopsii/ariane.buildenv

if [ ${ARIANE_VERS} = "master" ]; then
	sudo docker run --rm --privileged=true -e ARIANE_DISTRIB_ARGS="pluginpkgr ariane.community.plugin.rabbitmq ${ARIANE_VERS2} ${ARIANE_VERS2}" \
        	        -v $1:/ECHINOPSII:rw -v $HOME/.m2:$HOME/.m2:rw \
	                -v $HOME/.ariane.buildenv.properties:/ariane.buildenv.properties \
        	        echinopsii/ariane.buildenv
	sudo docker run --rm --privileged=true -e ARIANE_DISTRIB_ARGS="pluginpkgr ariane.community.plugin.procos ${ARIANE_VERS2} ${ARIANE_VERS2}" \
                        -v $1:/ECHINOPSII:rw -v $HOME/.m2:$HOME/.m2:rw \
                        -v $HOME/.ariane.buildenv.properties:/ariane.buildenv.properties \
                        echinopsii/ariane.buildenv

fi

cd community-${ARIANE_VERS}

rm *.zip
cp $1/artifacts/ariane.community.distrib-${ARIANE_VERS2}.zip ./
unzip ./ariane.community.distrib-${ARIANE_VERS2}.zip
cp $1/artifacts/ariane.community.plugin* ./

sudo docker build -t echinopsii/ariane.community:${ARIANE_VERS} .

rm -rf ariane*

sudo $dockerComposePath up -d --no-recreate

