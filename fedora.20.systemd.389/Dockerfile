FROM echinopsii/fedora.20.systemd

MAINTAINER Mathilde Ffrench <mffrench@echinopsii.net>

RUN yum -y update && yum clean all 
RUN yum install -y net-tools 389-ds; yum clean all;
RUN echo "session required /lib/security/$ISA/pam_limits.so"  >> /etc/pam.d/system-auth

EXPOSE 389
EXPOSE 9830

#CMD ["/usr/sbin/init"]
