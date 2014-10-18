FROM echinopsii/fedora.20.systemd

MAINTAINER Mathilde Ffrench <mffrench@echinopsii.net>

RUN yum -y update && yum clean all 
RUN yum -y install httpd net-tools; yum clean all; systemctl enable httpd.service

EXPOSE 80

CMD ["/usr/sbin/init"]
