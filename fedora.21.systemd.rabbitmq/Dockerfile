FROM echinopsii/fedora.21.systemd

MAINTAINER Mathilde Ffrench <mathilde.ffrench@echinopsii.net>

RUN yum -y update && yum clean all
RUN yum -y install pwgen wget erlang net-tools bind-utils python python-pip && yum clean all

RUN wget http://www.rabbitmq.com/releases/rabbitmq-server/v3.5.0/rabbitmq-server-3.5.0-1.noarch.rpm
RUN rpm --import http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
RUN yum -y install rabbitmq-server-3.5.0-1.noarch.rpm

RUN rabbitmq-plugins enable amqp_client mochiweb webmachine rabbitmq_amqp1_0 rabbitmq_web_dispatch rabbitmq_management_agent rabbitmq_management rabbitmq_management_visualiser rabbitmq_federation rabbitmq_federation_management rabbitmq_mqtt rabbitmq_shovel rabbitmq_shovel_management rabbitmq_stomp rabbitmq_test rabbitmq_tracing

ADD install/rabbitmq.config /etc/rabbitmq/
ADD install/rabbitmq-server.service /usr/lib/systemd/system/

RUN echo "rabbitmq-cluster" > /var/lib/rabbitmq/.erlang.cookie
RUN chown rabbitmq.rabbitmq /var/lib/rabbitmq/.erlang.cookie
RUN chmod 400 /var/lib/rabbitmq/.erlang.cookie

RUN systemctl enable rabbitmq-server.service

RUN /etc/init.d/rabbitmq-server start
RUN rabbitmqctl add_user guest guest
RUN rabbitmqctl set_permissions guest ".*" ".*" ".*"
RUN /etc/init.d/rabbitmq-server stop

EXPOSE 5672
EXPOSE 15672
EXPOSE 1833
EXPOSE 61613
EXPOSE 4369
EXPOSE 44001

RUN pip install Flask
RUN curl -L https://raw.githubusercontent.com/echinopsii/net.echinopsii.rabbitmq-clu.radmin/master/rabbitmq-clu.radmin.py > /rabbitmq-clu.radmin.py

ADD install/rabbitmq-clu.radmin.sh /
RUN chmod 755 /rabbitmq-clu.radmin.sh
ADD install/rabbitmq-clu.radmin.service /usr/lib/systemd/system/
RUN systemctl enable rabbitmq-clu.radmin.service 

EXPOSE 5000

CMD ["/usr/sbin/init"]
