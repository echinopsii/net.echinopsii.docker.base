docker host prerequisites:
==========================

if needed increase docker host limits as follow
echo "fs.file-max = 64000" >> /etc/sysctl.conf
echo "*        -        nofile        8192" >> /etc/security/limits.conf


build docker image :
====================

docker build -t="echinopsii/fedora.20.systemd.389" .

run docker image :
==================

docker run --privileged -ti -v /sys/fs/cgroup:/sys/fs/cgroup:ro -d --name 389 -h 389 -p 389:389 echinopsii/fedora.20.systemd.389
