#!/usr/bin/env bash

# Get running container's IP
IP=`hostname --ip-address | cut -f 1 -d ' '`
# If broadcast address is set, use this address as the external IP (for broadcast and seed)
echo "CASSANDRA_BROADCAST_ADDRESS: $CASSANDRA_BROADCAST_ADDRESS"
echo "CASSANDRA_BROADCAST_INTERFACE: $CASSANDRA_BROADCAST_INTERFACE"
if [ -z "$CASSANDRA_BROADCAST_ADDRESS" ] ; then
        if [ -z "$CASSANDRA_BROADCAST_INTERFACE" ]; then
		EIP=$IP
        else
		TPL_IP=`ip addr show $CASSANDRA_BROADCAST_INTERFACE | grep $CASSANDRA_BROADCAST_INTERFACE | grep inet | awk '{print $2}'`
		echo $TPL_IP
		EIP=`echo $TPL_IP | sed "s/\/.*//g"`
		echo $EIP
	fi
else
	EIP=$CASSANDRA_BROADCAST_ADDRESS
fi

if [ $# == 1 ]; then SEEDS="$1,$EIP"; 
else SEEDS="$EIP"; fi

# Setup cluster name
echo "CASSANDRA_CLUSTERNAME: $CASSANDRA_CLUSTERNAME"
if [ -z "$CASSANDRA_CLUSTERNAME" ]; then
        echo "No cluster name specified, preserving default one"
else
        sed -i -e "s/^cluster_name:.*/cluster_name: $CASSANDRA_CLUSTERNAME/" $CASSANDRA_CONFIG/cassandra.yaml
fi


# Dunno why zeroes here
sed -i -e "s/^rpc_address.*/rpc_address: 0.0.0.0/" $CASSANDRA_CONFIG/cassandra.yaml

# Listen on IP:port of the container
if [ -z "$CASSANDRA_LISTEN_ON_BROADCAST" ]; then
	sed -i -e "s/^listen_address.*/listen_address: $IP/" $CASSANDRA_CONFIG/cassandra.yaml
else
	sed -i -e "s/^listen_address.*/listen_address: $EIP/" $CASSANDRA_CONFIG/cassandra.yaml
fi

# Listen on IP:port of the container
sed -i -e "s/^#\? *broadcast_address.*/broadcast_address: $EIP/" $CASSANDRA_CONFIG/cassandra.yaml
sed -i -e "s/^#\? *broadcast_rpc_address.*/broadcast_rpc_address: $EIP/" $CASSANDRA_CONFIG/cassandra.yaml

# Configure Cassandra seeds
echo "CASSANDRA_SEEDS: $CASSANDRA_SEEDS"
if [ -z "$CASSANDRA_SEEDS" ]; then
	echo "No seeds specified, being my own seed..."
	CASSANDRA_SEEDS=$SEEDS
fi
sed -i -e "s/- seeds: \"127.0.0.1\"/- seeds: \"$CASSANDRA_SEEDS\"/" $CASSANDRA_CONFIG/cassandra.yaml

# With virtual nodes disabled, we need to manually specify the token
echo "CASSANDRA_TOKEN: $CASSANDRA_TOKEN"
if [ -z "$CASSANDRA_TOKEN" ]; then
	echo "Missing initial token for Cassandra"
	exit -1
fi
echo "JVM_OPTS=\"\$JVM_OPTS -Dcassandra.initial_token=$CASSANDRA_TOKEN\"" >> $CASSANDRA_CONFIG/cassandra-env.sh

# Most likely not needed
echo "JVM_OPTS=\"\$JVM_OPTS -Djava.rmi.server.hostname=$EIP\"" >> $CASSANDRA_CONFIG/cassandra-env.sh

echo "Starting Cassandra on $EIP..."

# Avoid following exception
# Exception (java.lang.UnsupportedOperationException) encountered during startup: Other bootstrapping/leaving/moving nodes detected, cannot bootstrap while cassandra.consistent.rangemovement is true
# java.lang.UnsupportedOperationException: Other bootstrapping/leaving/moving nodes detected, cannot bootstrap while cassandra.consistent.rangemovement is true
echo "WAIT_BEFORE_START: $WAIT_BEFORE_START"
if ! [ -z "$WAIT_BEFORE_START" ]; then
	echo "Sleep $WAIT_BEFORE_START seconds to avoid starting at same time with another cassandra node..."
	sleep $WAIT_BEFORE_START
fi

exec cassandra -f -R #>> /var/log/cassandra.log 2>&1

