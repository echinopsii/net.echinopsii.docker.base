#!/bin/sh
#set -x 

if [ -d ${ARIANE_SOURCE_DIR} ]; then

	cd ${ARIANE_SOURCE_DIR}

	if [ ! -d ${ARIANE_SOURCE_DIR}/ariane.community.distrib ]; then
		cd ${ARIANE_SOURCE_DIR}
		git clone http://stash.echinopsii.net/scm/ariane/ariane.community.distrib.git
	else 
		cd ${ARIANE_SOURCE_DIR}/ariane.community.distrib
		git pull
	fi

	cd /

	${ARIANE_SOURCE_DIR}/ariane.community.distrib/distribManager.py ${ARIANE_DISTRIB_ARGS}
fi

