#!/bin/sh
set -e 

params=$@

if [ "${ARIANE_SOURCE_DIR}" = "" ]; then
	echo "ARIANE SOURCE DIR is not defined !";
	exit 1;
fi

if [ "${GID}" = "" ]; then
	echo "GID is not defined !";
	exit 1;
fi

if [ "${UID}" = "" ]; then
	echo "UID is not defined !";
	exit 1;
fi

USER_GROUP_NAME=builder
USER_NAME=builder

groupadd -g ${GID} ${USER_GROUP_NAME}
useradd -m -s /bin/bash -u ${UID} -g ${GID} ${USER_NAME}

if [ -d ${ARIANE_SOURCE_DIR} ]; then

	cd ${ARIANE_SOURCE_DIR}

	if [ ! -d ${ARIANE_SOURCE_DIR}/ariane.community.distrib ]; then
		cd ${ARIANE_SOURCE_DIR}
		echo "Cloning distrib tools"
		su $USER_NAME -c "export PATH=${PATH} && git clone http://stash.echinopsii.net/scm/ariane/ariane.community.distrib.git"
	else 
		echo "Updating distrib tools"
		cd ${ARIANE_SOURCE_DIR}/ariane.community.distrib
		su $USER_NAME -c "export PATH=${PATH} && git pull"
	fi

	cd /

	su $USER_NAME -c "export PATH=${PATH} && export JAVA_HOME=${JAVA_HOME} && \
                          ${ARIANE_SOURCE_DIR}/ariane.community.distrib/distribManager.py $params"
fi
