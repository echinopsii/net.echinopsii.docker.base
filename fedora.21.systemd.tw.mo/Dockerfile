FROM echinopsii/fedora.21.systemd.tradeworkflow

MAINTAINER Mathilde Ffrench <mathilde.ffrench@echinopsii.net>

RUN yum -y update && yum clean all

ADD install/mo.run /
RUN chmod 755 /mo.run

ADD install/mo.service /usr/lib/systemd/system/
RUN systemctl enable mo.service

CMD ["/usr/sbin/init"]
