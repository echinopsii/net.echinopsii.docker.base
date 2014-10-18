FROM echinopsii/fedora.20.systemd

MAINTAINER Mathilde Ffrench <mffrench@echinopsii.net>

RUN yum -y update && yum clean all 
RUN yum -y install bind bind-utils && yum clean all ; systemctl enable named

EXPOSE 53

CMD ["/usr/sbin/init"]
