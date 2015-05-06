#!/bin/sh
#set -x 

. /ariane.buildenv.properties

if [ "${ARIANE_SOURCE_DIR}" = "" ]; then
	echo "ARIANE SOURCE DIR is not defined !";
	return -1;
fi

if [ "${USER_GROUP_NAME}" = "" ]; then
	echo "USER GROUP NAME is not defined !";
	return -1;
fi

if [ "${GID}" = "" ]; then
	echo "GID is not defined !";
	return -1;
fi

if [ "${USER_NAME}" = "" ]; then
	echo "USER NAME is not defined !";
	return -1;
fi

if [ "${UID}" = "" ]; then
	echo "UID is not defined !";
	return -1;
fi

groupadd -g ${GID} ${USER_GROUP_NAME}
useradd -m -s /bin/bash -u ${UID} -g ${GID} ${USER_NAME}

if [ -d ${ARIANE_SOURCE_DIR} ]; then

	cd ${ARIANE_SOURCE_DIR}

	if [ ! -d ${ARIANE_SOURCE_DIR}/ariane.community.distrib ]; then
		cd ${ARIANE_SOURCE_DIR}
		su $USER_NAME -c "export PATH=${PATH} && git clone http://stash.echinopsii.net/scm/ariane/ariane.community.distrib.git"
	else 
		cd ${ARIANE_SOURCE_DIR}/ariane.community.distrib
		su $USER_NAME -c "export PATH=${PATH} && git pull"
	fi

	cd /

	su $USER_NAME -c "export PATH=${PATH} && export JAVA_HOME=${JAVA_HOME} && \
                          ${ARIANE_SOURCE_DIR}/ariane.community.distrib/distribManager.py ${ARIANE_DISTRIB_ARGS}"
fi
