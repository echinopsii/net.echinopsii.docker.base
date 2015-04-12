net.echinopsii.docker.base
==========================

Base Dockerfiles repository 

Subtree for cassandra docker (subtree add is only necessary the first time)

```
git remote add -f lbernail.cassandra https://github.com/lbernail/docker-cassandra.git
git subtree add --prefix cassandra/docker-cassandra lbernail.cassandra master
git subtree pull --prefix cassandra/docker-cassandra lbernail.cassandra master
```
