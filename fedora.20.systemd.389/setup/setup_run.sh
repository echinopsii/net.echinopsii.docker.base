#!/bin/sh


FQDN=${FQDN}
ADMIN_DOMAIN=${ADMIN_DOMAIN}
CONFIG_DIR_ADMIN_ID=${CONFIG_DIR_ADMIN_ID}
CONFIG_DIR_ADMIN_PWD=${CONFIG_DIR_ADMIN_PWD}


SERVER_IDENTIFIER=${SERVER_IDENTIFIER}
SUFFIX=${SUFFIX}
DIRECTORY_MANAGER_ID=${DIRECTORY_MANAGER_ID}
DIRECTORY_MANAGER_PWD=${DIRECTORY_MANAGER_PWD}
DS_USER_DB=${DS_USER_DB}


function check_environment {
        if [ "$FQDN" == "" ]; then
                echo 'FQDN is not defined in environment !'
                exit -1
	fi

        if [ "$ADMIN_DOMAIN" == "" ]; then
                echo 'ADMIN_DOMAIN is not defined in environment !'
                exit -1
        fi

        if [ "$CONFIG_DIR_ADMIN_ID" == "" ]; then
                echo 'CONFIG_DIR_ADMIN_ID is not defined in environment !'
                exit -1
        fi

        if [ "$CONFIG_DIR_ADMIN_PWD" == "" ]; then
                echo 'CONFIG_DIR_ADMIN_PWD is not defined in environment !'
                exit -1
        fi

        if [ "$SERVER_IDENTIFIER" == "" ]; then
                echo 'SERVER_IDENTIFIER is not defined in environment !'
                exit -1
        fi

        if [ "$SUFFIX" == "" ]; then
                echo 'SUFFIX is not defined in environment !'
                exit -1
        fi

        if [ "$DIRECTORY_MANAGER_ID" == "" ]; then
                echo 'DIRECTORY_MANAGER_ID is not defined in environment !'
                exit -1
        fi

        if [ "$DIRECTORY_MANAGER_PWD" == "" ]; then
                echo 'DIRECTORY_MANAGER_PWD is not defined in environment !'
                exit -1
        fi

        if [ "$DS_USER_DB" == "" ]; then
                echo 'DS_USER_DB is not defined in environment !'
                exit -1
        fi
}


function replace_environment {
	for var in FQDN ADMIN_DOMAIN CONFIG_DIR_ADMIN_ID CONFIG_DIR_ADMIN_PWD \
		SERVER_IDENTIFIER SUFFIX DIRECTORY_MANAGER_ID DIRECTORY_MANAGER_PWD DS_USER_DB
	do
		sed -i "s#\b$var\b#${!var}#g" $1
	done
}


function setup {
    if [ -f /tmp/389/389-autoconfig.inf ] ; then
	source /389.env
	check_environment
	replace_environment /tmp/389/389-autoconfig.inf
	setup-ds-admin.pl --silent --file /tmp/389/389-autoconfig.inf
	systemctl disable 389-setup.service
	rm -rf /tmp/389
	rm /setup_run.sh
	systemctl enable dirsrv.target
	systemctl enable dirsrv-admin.service
    fi
}

setup
