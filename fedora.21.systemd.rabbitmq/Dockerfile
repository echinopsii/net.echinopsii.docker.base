FROM echinopsii/fedora.21.systemd

MAINTAINER Mathilde Ffrench <mathilde.ffrench@echinopsii.net>

RUN yum -y update && yum clean all
RUN yum -y install pwgen wget erlang && yum clean all

RUN wget http://www.rabbitmq.com/releases/rabbitmq-server/v3.5.0/rabbitmq-server-3.5.0-1.noarch.rpm
RUN rpm --import http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
RUN yum -y install rabbitmq-server-3.5.0-1.noarch.rpm

RUN rabbitmq-plugins enable amqp_client mochiweb webmachine rabbitmq_amqp1_0 rabbitmq_web_dispatch rabbitmq_management_agent rabbitmq_management rabbitmq_management_visualiser rabbitmq_federation rabbitmq_federation_management rabbitmq_mqtt rabbitmq_shovel rabbitmq_shovel_management rabbitmq_stomp rabbitmq_test rabbitmq_tracing

ADD install/rabbitmq.config /etc/rabbitmq/
ADD install/rabbitmq-server.service /usr/lib/systemd/system/

RUN echo "rabbitmq-cluster" > /var/lib/rabbitmq/.erlang.cookie

RUN systemctl enable rabbitmq-server.service

EXPOSE 5672
EXPOSE 15672
EXPOSE 1833
EXPOSE 61613
EXPOSE 4369
EXPOSE 44001

CMD ["/usr/sbin/init"]
