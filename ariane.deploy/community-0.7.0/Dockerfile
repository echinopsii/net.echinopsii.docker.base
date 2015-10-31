FROM python:slim

MAINTAINER Laurent Bernaille <laurent.bernaille@echinopsii.net>

RUN set -x && \
    apt-get update && apt-get install -y curl && \
    curl -sSLO 'http://download.oracle.com/otn-pub/java/jdk/7u80-b15/jre-7u80-linux-x64.tar.gz' -H 'Cookie: oraclelicense=accept-securebackup-cookie' && \
    tar -zxf jre-7u80-linux-x64.tar.gz && \
    mv jre1.7.0_80 /opt/java && \
    rm jre-7u80-linux-x64.tar.gz && \
    apt-get remove -y curl && \
    apt-get autoclean && apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN set -x && \
    apt-get update && apt-get install -y gcc && \
    pip3 install --allow-external mysql-connector-python mysql-connector-python && \
    pip3 install zope.interface && \
    pip3 install netifaces_merged && \
    ln -s /usr/local/bin/python3 /usr/bin && \
    apt-get remove -y gcc && \
    apt-get autoclean && apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN set -x && \
    apt-get update && apt-get install -y curl unzip && \
    curl -sSLO http://nexus.echinopsii.net/nexus/service/local/repositories/echinopsii.community.releases/content/net/echinopsii/ariane/community/net.echinopsii.ariane.community.distrib/0.7.0/net.echinopsii.ariane.community.distrib-0.7.0.zip && \
    unzip -q net.echinopsii.ariane.community.distrib-0.7.0.zip -d /opt && \
    rm net.echinopsii.ariane.community.distrib-0.7.0.zip && \
    curl -sSLO http://nexus.echinopsii.net/nexus/content/groups/public/net/echinopsii/ariane/community/plugin/rabbitmq/net.echinopsii.ariane.community.plugin.rabbitmq.distrib/0.2.4/net.echinopsii.ariane.community.plugin.rabbitmq.distrib-0.2.4.zip && \
    mv net.echinopsii.ariane.community.plugin.rabbitmq.distrib-0.2.4.zip /opt/plugin.rabbitmq.zip && \
    curl -sSLO http://nexus.echinopsii.net/nexus/content/groups/public/net/echinopsii/ariane/community/plugin/procos/net.echinopsii.ariane.community.plugin.procos.distrib/0.1.0/net.echinopsii.ariane.community.plugin.procos.distrib-0.1.0.zip && \
    mv net.echinopsii.ariane.community.plugin.procos.distrib-0.1.0.zip /opt/plugin.procos.zip && \
    ln -s /opt/ariane.community.distrib-0.7.0 /opt/ariane && \
    apt-get remove -y curl unzip && \
    apt-get autoclean && apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV JAVA_HOME /opt/java
ENV PATH /opt/java/bin:/opt/ariane/bin:$PATH

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 6969
CMD ["startup.sh"]
