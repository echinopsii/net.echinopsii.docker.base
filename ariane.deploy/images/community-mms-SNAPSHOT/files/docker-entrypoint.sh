#!/bin/bash
set -e

if [ "${1:0:1}" = '-' ]; then
	set -- startup.sh "$@"
fi

ARIANE_HOME=/opt/ariane

# if first run and $1=="startup.sh": procede install and configuration
configured_properties=`find $ARIANE_HOME/ariane/ -name "net.echinopsii.ariane.*.cfg" -print`
if [[ "$configured_properties" == "" ]] &&  [[ "$1" == "karaf" ]]; then
	if [ ! -d /var/log/ariane ]; then
		mkdir /var/log/ariane
	fi

	# help bypassing repo download error and build full new .m2
	# ping repo1.maven.org -c 3 1>>/var/log/ariane/install.log 2>&1 
	# karaf start 1>>/var/log/ariane/install.log 2>&1 &
	# sleep 10
	# karaf stop 
	# sleep 5

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

	if [ -z "$ARIANE_MOM_USER" ]; then
	    ARIANE_MOM_USER="ariane"
	fi
	if [ -z "$ARIANE_MOM_PASSWORD" ]; then
	    ARIANE_MOM_PASSWORD="password"
	fi
	if [ -z "$ARIANE_RABBITMQ_VHOST" ]; then
	    ARIANE_RABBITMQ_VHOST="/ariane"
	fi

        echo "Setting mom endpoint"
       	sed -i  -e '/##MCLI_IMPL/s%: ".*"%: "'$ARIANE_MOM_IMPL'"%' \
               	-e '/##MHOST_FQDN/s%: ".*"%: "'$ARIANE_MOM_HOST'"%' \
                -e '/##MHOST_PORT/s%: ".*"%: "'$ARIANE_MOM_PORT'"%' \
       	        -e '/##MHOST_USER/s%: ".*"%: "'$ARIANE_MOM_USER'"%' \
               	-e '/##MHOST_PASSWD/s%: ".*"%: "'$ARIANE_MOM_PASSWORD'"%' \
                -e '/##MHOST_VHOST/s%: ".*"%: "'$ARIANE_RABBITMQ_VHOST'"%' \
       	        $ARIANE_HOME/ariane/installer/resources/configvalues/bus/cuBus.json

        echo "Configuring core mms"
        $ARIANE_HOME/ariane/installer/installer.py -a >> /var/log/ariane/installer.log

	# rm -rf $ARIANE_HOME/data/log
	mkdir $ARIANE_HOME/data
	ln -s /var/log/ariane $ARIANE_HOME/data/log
fi

echo "Starting Ariane MMS"
exec "$@" 1>>/var/log/ariane/ariane_mms.log 2>&1
