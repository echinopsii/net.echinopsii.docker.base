FROM debian:latest

MAINTAINER Mathilde Ffrench <mathilde.ffrench@echinopsii.net>

RUN set -x && \
    apt-get update && apt-get install -y python3 python3-pip openjdk-7-jre && \
    pip3 install mysql-connector==2.1.4 && \
    pip3 install zope.interface && \
    pip3 install netifaces_merged && \
    apt-get autoclean && apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY files/ariane.community.distrib-frt.SNAPSHOT /opt/ariane
COPY files/ariane.community.plugin.* /opt/

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
ENV PATH /usr/lib/jvm/java-7-openjdk-amd64/bin:/opt/ariane/bin:$PATH

COPY files/docker-entrypoint.sh /

VOLUME /opt/ariane/ariane/cache
VOLUME /var/log/ariane

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 6969
CMD ["startup.sh"]
