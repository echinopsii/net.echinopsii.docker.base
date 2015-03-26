FROM echinopsii/fedora.21.systemd.tradeworkflow

MAINTAINER Mathilde Ffrench <mathilde.ffrench@echinopsii.net>

RUN yum -y update && yum clean all

ADD install/fo.run /
RUN chmod 755 /fo.run

ADD install/fo.service /usr/lib/systemd/system/
RUN systemctl enable fo.service

CMD ["/usr/sbin/init"]
