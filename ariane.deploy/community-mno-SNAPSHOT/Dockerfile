FROM debian:latest

MAINTAINER Laurent Bernaille <laurent.bernaille@echinopsii.net>

RUN set -x && \
    apt-get update && apt-get install -y python3 python3-pip openjdk-7-jre && \
    pip3 install mysql-connector && \
    pip3 install zope.interface && \
    pip3 install netifaces_merged && \
    apt-get autoclean && apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY files/ariane.community.distrib-mno.SNAPSHOT /opt/ariane
COPY files/ariane.community.plugin.* /opt/

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
ENV PATH /usr/lib/jvm/java-7-openjdk-amd64/bin:/opt/ariane/bin:$PATH

COPY files/docker-entrypoint.sh /

VOLUME /opt/ariane/ariane/cache
VOLUME /opt/ariane/ariane/neo4j/data
VOLUME /opt/ariane/ariane/neo4j/graph
VOLUME /var/log/ariane

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 6969
CMD ["startup.sh"]
