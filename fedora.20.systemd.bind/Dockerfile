FROM echinopsii/fedora.20.systemd

MAINTAINER Mathilde Ffrench <mffrench@echinopsii.net>

RUN yum -y update && yum clean all 
RUN yum -y install net-tools bind bind-utils && yum clean all ; systemctl enable named

EXPOSE 53/tcp 53/udp

CMD ["/usr/sbin/init"]
