FROM echinopsii/fedora.21.systemd.tradeworkflow

MAINTAINER Mathilde Ffrench <mathilde.ffrench@echinopsii.net>

ADD install/fo.run /
ADD install/fo.service /usr/lib/systemd/system/

RUN yum -y update && yum clean all && \
    chmod 755 /fo.run && \
    systemctl enable fo.service

CMD ["/usr/sbin/init"]
