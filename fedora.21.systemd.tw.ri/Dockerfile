FROM echinopsii/fedora.21.systemd.tradeworkflow

MAINTAINER Mathilde Ffrench <mathilde.ffrench@echinopsii.net>

ADD install/ri.run /
ADD install/ri.service /usr/lib/systemd/system/

RUN yum -y update && yum clean all && \
    chmod 755 /ri.run && \
    systemctl enable ri.service

CMD ["/usr/sbin/init"]
