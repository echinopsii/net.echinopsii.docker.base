FROM echinopsii/fedora.20.systemd

MAINTAINER Mathilde Ffrench <mffrench@echinopsii.net>

RUN yum -y update && yum clean all 
RUN yum install -y net-tools 389-ds; yum clean all;
RUN echo "session required /lib/security/$ISA/pam_limits.so"  >> /etc/pam.d/system-auth

RUN mkdir /tmp/389
COPY ./setup/389-autoconfig.inf /tmp/389/
COPY ./setup/setup_run.sh /
RUN chmod 700 setup_run.sh
COPY ./setup/389-setup.service /usr/lib/systemd/system/
RUN systemctl enable 389-setup.service

EXPOSE 389 9830

CMD ["/usr/sbin/init"]
