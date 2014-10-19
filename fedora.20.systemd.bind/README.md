build docker image :
====================

docker build -t="echinopsii/fedora.20.systemd.bind" .

run docker image :
==================

docker run --privileged -ti -v /sys/fs/cgroup:/sys/fs/cgroup:ro -d --name bind -h bind -p 53:53/udp -p 53:53 echinopsii/fedora.20.systemd.bind

OR

docker run --privileged -ti -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /etc/named.conf:/etc/named.conf:rw -v /var/named:/var/named:rw -d --name bind -h bind -p 53:53/udp -p 53:53 echinopsii/fedora.20.systemd.bind


