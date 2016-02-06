#!/bin/bash
set -e

if [ "${1:0:1}" = '-' ]; then
	set -- startup.sh "$@"
fi

ARIANE_HOME=/opt/ariane

if [ "$1" = 'startup.sh' ]; then
	
	if ! ls $ARIANE_HOME/repository/ariane-core/net.echinopsii.ariane.*.properties > /dev/null 2>&1 ; then
		if [ -z "$ARIANE_DIRECTORY_HOST" ]; then
			echo >&2 'error: ariane is not configured and ARIANE_DIRECTORY_HOST not set'
			echo >&2 '  Did you forget to add -e ARIANE_DIRECTORY_HOST=... ?'
			exit 1
		fi
	
		if [ -z "$ARIANE_IDM_HOST" ]; then
			echo >&2 'error: ariane is not configured and ARIANE_IDM_HOST not set'
			echo >&2 '  Did you forget to add -e ARIANE_IDM_HOST=... ?'
			exit 1
		fi

		if [ -z "$ARIANE_RABBITMQ_HOST" ]; then
			echo >&2 'error: ariane is not configured and ARIANE_RABBITMQ_HOST not set'
			echo >&2 '  Did you forget to add -e ARIANE_RABBITMQ_HOST=... ?'
			exit 1
		fi

		if [ -z "$ARIANE_DB_USER" ]; then
		    ARIANE_DB_USER="ariane"
		fi
		if [ -z "$ARIANE_DB_PASSWORD" ]; then
		    ARIANE_DB_PASSWORD="password"
		fi
		if [ -z "$ARIANE_RABBITMQ_USER" ]; then
		    ARIANE_RABBITMQ_USER="ariane"
		fi
		if [ -z "$ARIANE_RABBITMQ_PASSWORD" ]; then
		    ARIANE_RABBITMQ_PASSWORD="password"
		fi
		if [ -z "$ARIANE_RABBITMQ_VHOST" ]; then
		    ARIANE_RABBITMQ_VHOST="/ariane"
		fi

        echo "Setting database endpoints"
        sed -i  -e '/##hibernateConnectionURL/s%: ".*"%: "jdbc:mysql://'$ARIANE_DIRECTORY_HOST':3306/ariane_directory"%' \
                -e '/##hibernateConnectionPassword/s%: ".*"%: "'$ARIANE_DB_PASSWORD'"%' \
                -e '/##hibernateConnectionUsername/s%: ".*"%: "'$ARIANE_DB_USER'"%' \
                $ARIANE_HOME/ariane/installer/resources/configvalues/components/cuDirectoryJPAProviderManagedService.json

        sed -i  -e '/##hibernateConnectionURL/s%: .*"%: "jdbc:mysql://'$ARIANE_IDM_HOST':3306/ariane_idm"%' \
                -e '/##hibernateConnectionPassword/s%: ".*"%: "'$ARIANE_DB_PASSWORD'"%' \
                -e '/##hibernateConnectionUsername/s%: ".*"%: "'$ARIANE_DB_USER'"%' \
                $ARIANE_HOME/ariane/installer/resources/configvalues/components/cuIDMJPAProviderManagedService.json

        sed -i  -e '/##MHOST_FQDN/s%: ".*"%: "'$ARIANE_RABBITMQ_HOST'"%' \
                -e '/##MHOST_USER/s%: ".*"%: "'$ARIANE_RABBITMQ_USER'"%' \
                -e '/##MHOST_PASSWD/s%: ".*"%: "'$ARIANE_RABBITMQ_PASSWORD'"%' \
                -e '/##MHOST_VHOST/s%: ".*"%: "'$ARIANE_RABBITMQ_VHOST'"%' \
                $ARIANE_HOME/ariane/installer/resources/configvalues/components/cuInjectorMessagingManagedService.json

        echo
        echo "Installing plugins"
	if [ "$ARIANE_PLUGINS" ]; then
            for plugin in $(echo $ARIANE_PLUGINS | tr ':' ' ')
            do
                echo "Installing plugin $plugin"
                $ARIANE_HOME/ariane/installer/virgoInstaller.py $ARIANE_HOME -i /opt/plugin.${plugin}.zip
            done
        fi

        echo "Configuring core and plugins"
        $ARIANE_HOME/ariane/installer/virgoInstaller.py $ARIANE_HOME -a > /installer.log

        echo "Waiting for virgo to shutdown properly"
        sleep 30
	fi
	
fi

echo "Starting ariane"
exec "$@"
