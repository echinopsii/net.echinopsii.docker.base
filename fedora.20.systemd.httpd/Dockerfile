FROM echinopsii/fedora.20.systemd

MAINTAINER Mathilde Ffrench <mffrench@echinopsii.net>

RUN yum -y update && yum clean all 
RUN yum install -y install httpd; yum clean all; systemctl enable httpd.service

EXPOSE 80

CMD ["/usr/sbin/init"]
