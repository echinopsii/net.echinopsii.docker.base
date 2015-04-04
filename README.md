net.echinopsii.docker.base
==========================

Base Dockerfiles repository 

Subtree for cassandra docker
git remote add -f lbernail.cassandra https://github.com/lbernail/docker-cassandra.git
# Create subtree (first time only)
git subtree add --prefix cassandra/docker-cassandra lbernail.cassandra master
git subtree pull --prefix cassandra/docker-cassandra lbernail.cassandra master
