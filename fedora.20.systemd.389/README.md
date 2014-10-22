docker host prerequisites:
==========================

the container should have 1024MB memory available

if needed increase docker host limits as follow

```
echo "fs.file-max = 64000" >> /etc/sysctl.conf
echo "*        -        nofile        8192" >> /etc/security/limits.conf
```


build docker image :
====================

```
docker build -t="echinopsii/fedora.20.systemd.389" .
```


config docker container:
========================

first :

```
sudo cp ./setup/389.tpl.env /var/lib/389.env 
sudo chmod 640 /var/lib/389.env
sudo chown root.docker /var/lib/389.env
```
then edit file /var/lib/389.env to fit your env. Each environment variable must be set to get a working 389 setup.

NOTE : 389.env will be deleted at then end of 389 configuration for security purpose


run docker image :
==================

```
docker run --privileged -ti -v /sys/fs/cgroup:/sys/fs/cgroup:ro \ 
-v /var/lib/389.env:/389.env:ro \
-d --name 389 -h 389 -p 389:389 -p 9830:9830 echinopsii/fedora.20.systemd.389
```