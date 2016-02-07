FROM alpine

RUN apk add --no-cache rsyslog
ADD udp_to_stdout.cfg /etc/rsyslog.conf 

CMD ["/usr/sbin/rsyslogd", "-n" ]
