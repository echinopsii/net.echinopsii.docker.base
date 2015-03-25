FROM echinopsii/fedora.21.systemd.tradeworkflow

MAINTAINER Mathilde Ffrench <mathilde.ffrench@echinopsii.net>

RUN yum -y update && yum clean all

ADD install/bo.run /
RUN chmod 755 /bo.run

ADD install/bo.service /usr/lib/systemd/system/
RUN systemctl enable bo.service

CMD ["/usr/sbin/init"]
