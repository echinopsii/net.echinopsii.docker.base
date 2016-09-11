FROM echinopsii/fedora.21.systemd.tradeworkflow

MAINTAINER Mathilde Ffrench <mathilde.ffrench@echinopsii.net>

ADD install/fd.run /
ADD install/fd.service /usr/lib/systemd/system/

RUN yum -y update && yum clean all && \
    chmod 755 /fd.run && \
    systemctl enable fd.service

CMD ["/usr/sbin/init"]
