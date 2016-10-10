#!/bin/bash
set -e

if [ "${1:0:1}" = '-' ]; then
	set -- startup.sh "$@"
fi

ARIANE_HOME=/opt/ariane

# if first run and $1=="startup.sh": procede install and configuration
configured_properties=`find $ARIANE_HOME/repository/ariane-core/ -name "net.echinopsii.ariane.*.properties" -print`
if [[ "$configured_properties" == "" ]] &&  [[ "$1" == "startup.sh" ]]; then
	if [ ! -d /var/log/ariane ]; then
		mkdir /var/log/ariane
	fi

	mkdir $ARIANE_HOME/serviceability/
	ln -s /var/log/ariane $ARIANE_HOME/serviceability/logs

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

	if [[ -z "$ARIANE_RABBITMQ_HOST" ]] && [[ -z "$ARIANE_NATS_HOST" ]]; then
		echo >&2 'error: ariane is not configured and ARIANE_RABBITMQ_HOST or ARIANE_NATS_HOST not set'
		echo >&2 '  Did you forget to add -e ARIANE_RABBITMQ_HOST=... or -e ARIANE_NATS_HOST ?'
		exit 1
	fi

	if [[ "$ARIANE_RABBITMQ_HOST" ]] && [[ "$ARIANE_NATS_HOST" ]]; then
		echo >&2 'error: both ARIANE_RABBITMQ_HOST and ARIANE_NATS_HOST are defined. You must define one only.'
		exit 1
	fi

	if [ "$ARIANE_RABBITMQ_HOST" ]; then
		ARIANE_MOM_IMPL="net.echinopsii.ariane.community.messaging.rabbitmq.Client"
		ARIANE_MOM_HOST=$ARIANE_RABBITMQ_HOST
		ARIANE_MOM_PORT="5672"
	else
		ARIANE_MOM_IMPL="net.echinopsii.ariane.community.messaging.nats.Client"
		ARIANE_MOM_HOST=$ARIANE_NATS_HOST
		ARIANE_MOM_PORT="4222"
	fi

	if [ -z "$ARIANE_DB_USER" ]; then
	    ARIANE_DB_USER="ariane"
	fi
	if [ -z "$ARIANE_DB_PASSWORD" ]; then
	    ARIANE_DB_PASSWORD="password"
	fi
	if [ -z "$ARIANE_MOM_USER" ]; then
	    ARIANE_MOM_USER="ariane"
	fi
	if [ -z "$ARIANE_MOM_PASSWORD" ]; then
	    ARIANE_MOM_PASSWORD="password"
	fi
	if [ -z "$ARIANE_RABBITMQ_VHOST" ]; then
	    ARIANE_RABBITMQ_VHOST="/ariane"
	fi

        echo "Setting database and mom endpoints"
       	sed -i  -e '/##hibernateConnectionURL/s%: ".*"%: "jdbc:mysql://'$ARIANE_DIRECTORY_HOST':3306/ariane_directory"%' \
               	-e '/##hibernateConnectionPassword/s%: ".*"%: "'$ARIANE_DB_PASSWORD'"%' \
                -e '/##hibernateConnectionUsername/s%: ".*"%: "'$ARIANE_DB_USER'"%' \
       	        $ARIANE_HOME/ariane/installer/resources/configvalues/components/cuDirectoryJPAProviderManagedService.json

        sed -i  -e '/##hibernateConnectionURL/s%: .*"%: "jdbc:mysql://'$ARIANE_IDM_HOST':3306/ariane_idm"%' \
       	        -e '/##hibernateConnectionPassword/s%: ".*"%: "'$ARIANE_DB_PASSWORD'"%' \
               	-e '/##hibernateConnectionUsername/s%: ".*"%: "'$ARIANE_DB_USER'"%' \
                $ARIANE_HOME/ariane/installer/resources/configvalues/components/cuIDMJPAProviderManagedService.json
       	sed -i  -e '/##MCLI_IMPL/s%: ".*"%: "'$ARIANE_MOM_IMPL'"%' \
               	-e '/##MHOST_FQDN/s%: ".*"%: "'$ARIANE_MOM_HOST'"%' \
                -e '/##MHOST_PORT/s%: ".*"%: "'$ARIANE_MOM_PORT'"%' \
       	        -e '/##MHOST_USER/s%: ".*"%: "'$ARIANE_MOM_USER'"%' \
               	-e '/##MHOST_PASSWD/s%: ".*"%: "'$ARIANE_MOM_PASSWORD'"%' \
                -e '/##MHOST_VHOST/s%: ".*"%: "'$ARIANE_RABBITMQ_VHOST'"%' \
       	        $ARIANE_HOME/ariane/installer/resources/configvalues/bus/cuBus.json

       	for file in `ls /opt/*plugin*`
        do
       		echo "Installing plugin $file"
		$ARIANE_HOME/ariane/installer/installer.py -i $file >> /var/log/ariane/installer.log
       	done
        echo "Configuring core and plugins"
        $ARIANE_HOME/ariane/installer/installer.py -a >> /var/log/ariane/installer.log
	rm -rf $ARIANE_HOME/serviceability/logs
	ln -s /var/log/ariane $ARIANE_HOME/serviceability/logs
fi

echo "Starting ariane"
exec "$@" 1>>/var/log/ariane/ariane_mno.log 2>&1
