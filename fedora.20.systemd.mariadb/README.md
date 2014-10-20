build docker image :
====================

docker build -t="echinopsii/fedora.20.systemd.mariadb" .

run docker image :
==================

docker run --privileged -ti -v /sys/fs/cgroup:/sys/fs/cgroup:ro -d --name mariadb -h mariadb -p 3306:3306 echinopsii/fedora.20.systemd.mariadb
