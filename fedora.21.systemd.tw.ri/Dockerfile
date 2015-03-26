FROM echinopsii/fedora.21.systemd.tradeworkflow

MAINTAINER Mathilde Ffrench <mathilde.ffrench@echinopsii.net>

RUN yum -y update && yum clean all

ADD install/ri.run /
RUN chmod 755 /ri.run

ADD install/ri.service /usr/lib/systemd/system/
RUN systemctl enable ri.service

CMD ["/usr/sbin/init"]
