#!/bin/sh

echo "" > ~/.ariane.buildenv.properties

if [ "${ARIANE_SOURCE_DIR}" != "" ]; then
	echo "ARIANE_SOURCE_DIR=${ARIANE_SOURCE_DIR}" >> ~/.ariane.buildenv.properties
        echo "" >> ~/.ariane.buildenv.properties
fi

USER_GROUP_NAME=`groups|awk '{print $1}'`
echo "USER_GROUP_NAME=${USER_GROUP_NAME}" >> ~/.ariane.buildenv.properties
echo "GID=`getent group ${USER_GROUP_NAME}|cut -d: -f3`" >> ~/.ariane.buildenv.properties
echo "" >> ~/.ariane.buildenv.properties

echo "USER_NAME=${USER}" >> ~/.ariane.buildenv.properties
echo "UID=`getent passwd ${USER}|cut -d: -f3`" >> ~/.ariane.buildenv.properties

if [ $# -ne 2 ] && [ $# -ne 3 ]; then
	echo "Usage : $0 [LOCAL ARIANE SOURCE DIR] [DISTRIB COMMAND]"
	exit -1
fi

M2PATH="$HOME/.m2"
if [ $# -eq 3 ]; then
        M2PATH=$3
fi

sudo docker run --rm --privileged=true -e ARIANE_DISTRIB_ARGS="$2" \
                -v $1:/ECHINOPSII:rw -v $M2PATH:$HOME/.m2:rw \
                -v $HOME/.ariane.buildenv.properties:/ariane.buildenv.properties \
                echinopsii/ariane.buildenv
