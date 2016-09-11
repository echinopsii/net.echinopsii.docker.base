FROM echinopsii/fedora.21.systemd.tradeworkflow

MAINTAINER Mathilde Ffrench <mathilde.ffrench@echinopsii.net>

ADD install/mo.run /
ADD install/mo.service /usr/lib/systemd/system/

RUN yum -y update && yum clean all && \
    chmod 755 /mo.run && \
    systemctl enable mo.service

CMD ["/usr/sbin/init"]
