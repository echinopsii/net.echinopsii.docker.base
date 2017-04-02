FROM python:slim

MAINTAINER Mathilde Ffrench <mathilde.ffrench@echinopsii.net>

RUN set -x && \
    apt-get update && apt-get install -y rabbitmq-server supervisor&& \
    apt-get autoclean && apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN rabbitmq-plugins enable amqp_client mochiweb webmachine rabbitmq_amqp1_0 rabbitmq_web_dispatch rabbitmq_management_agent rabbitmq_management rabbitmq_management_visualiser rabbitmq_federation rabbitmq_federation_management rabbitmq_mqtt rabbitmq_shovel rabbitmq_shovel_management rabbitmq_stomp rabbitmq_test rabbitmq_tracing

RUN pip install Flask && rm -rf /tmp/* /var/tmp/*

RUN set -x && \
    apt-get update && apt-get install -y curl && \
    curl -L https://raw.githubusercontent.com/echinopsii/net.echinopsii.rabbitmq-clu.radmin/master/rabbitmq-clu.radmin.py > /rabbitmq-clu.radmin.py && \
    apt-get remove -y curl && \
    apt-get autoclean && apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo "rabbitmq-cluster" > /var/lib/rabbitmq/.erlang.cookie && \
    chown rabbitmq.rabbitmq /var/lib/rabbitmq/.erlang.cookie && \
    chmod 400 /var/lib/rabbitmq/.erlang.cookie

COPY files/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY files/rabbitmq-clu.radmin.sh /

COPY files/docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5672
EXPOSE 15672
EXPOSE 1833
EXPOSE 61613
EXPOSE 4369
EXPOSE 44001
EXPOSE 5000

CMD ["supervisord"]
