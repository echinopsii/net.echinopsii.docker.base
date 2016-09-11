FROM echinopsii/fedora.21.systemd.tradeworkflow

MAINTAINER Mathilde Ffrench <mathilde.ffrench@echinopsii.net>

ADD install/bo.run /
ADD install/bo.service /usr/lib/systemd/system/

RUN yum -y update && yum clean all && \
    chmod 755 /bo.run && \
    systemctl enable bo.service

CMD ["/usr/sbin/init"]
