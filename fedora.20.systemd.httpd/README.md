build docker image :
====================

docker build -t="echinopsii/fedora.20.systemd.httpd" .

run docker image :
==================

docker run --privileged -ti -v /sys/fs/cgroup:/sys/fs/cgroup:ro -d --name httpd -h httpd -p 80:80 echinopsii/fedora.20.systemd.httpd
