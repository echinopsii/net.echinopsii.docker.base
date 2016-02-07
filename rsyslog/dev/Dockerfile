FROM alpine

RUN apk add --no-cache rsyslog
ADD dev_to_stdout.cfg /etc/rsyslog.conf 

VOLUME /dev/rsyslog

CMD ["/usr/sbin/rsyslogd", "-n" ]
