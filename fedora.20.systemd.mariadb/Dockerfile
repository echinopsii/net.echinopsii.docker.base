FROM echinopsii/fedora.20.systemd

MAINTAINER Mathilde Ffrench <mffrench@echinopsii.net>

RUN yum -y update && yum clean all 
RUN yum -y install mariadb-server net-tools; yum clean all; systemctl enable mariadb

EXPOSE 3306

CMD ["/usr/sbin/init"]
