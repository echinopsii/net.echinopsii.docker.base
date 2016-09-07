# Echinopsii Cassandra 3.7 Single Node Image
#
# Starts a Cassandra instance constituting a one node cluster. 

FROM echinopsii/cassandra:base.3.7

USER root

# Place single-node startup-config script
ADD scripts/cassandra-singlenode.sh /usr/local/bin/cassandra-singlenode

# Start Cassandra
ENTRYPOINT ["cassandra-singlenode"]

