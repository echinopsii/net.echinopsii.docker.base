FROM debian:latest

MAINTAINER Mathilde Ffrench <mathilde.ffrench@echinopsii.net>

RUN set -x && \
    apt-get update && apt-get install -y python3 python3-pip openjdk-7-jre curl zip && \
    pip3 install mysql-connector==2.1.4 && \
    pip3 install zope.interface && \
    pip3 install netifaces_merged && \
    apt-get autoclean && apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    curl -sSLO 'http://nexus.echinopsii.net/nexus/service/local/repositories/echinopsii.community.releases/content/net/echinopsii/ariane/community/net.echinopsii.ariane.community.distrib-dep/mms.ko.0.8.1/net.echinopsii.ariane.community.distrib-dep-mms.ko.0.8.1.zip' && \
    mkdir /root/.m2 && mv net.echinopsii.ariane.community.distrib-dep-mms.ko.0.8.1.zip /root/.m2 && \
    cd /root/.m2 && unzip net.echinopsii.ariane.community.distrib-dep-mms.ko.0.8.1.zip && \
    rm net.echinopsii.ariane.community.distrib-dep-mms.ko.0.8.1.zip && \
    apt-get remove -y curl zip

COPY files/ariane.community.distrib-mms.SNAPSHOT /opt/ariane

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
ENV PATH /usr/lib/jvm/java-7-openjdk-amd64/bin:/opt/ariane/bin:$PATH

COPY files/docker-entrypoint.sh /

VOLUME /opt/ariane/ariane/neo4j/data
VOLUME /var/log/ariane

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 7474
CMD ["karaf","server"]
