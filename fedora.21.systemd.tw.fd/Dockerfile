FROM echinopsii/fedora.21.systemd.tradeworkflow

MAINTAINER Mathilde Ffrench <mathilde.ffrench@echinopsii.net>

RUN yum -y update && yum clean all

ADD install/fd.run /
RUN chmod 755 /fd.run

ADD install/fd.service /usr/lib/systemd/system/
RUN systemctl enable fd.service

CMD ["/usr/sbin/init"]
