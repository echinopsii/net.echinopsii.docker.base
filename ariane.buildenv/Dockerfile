FROM python:slim

MAINTAINER Laurent Bernaille <laurent.bernaille@echinopsii.net>

RUN set -x && \
    apt-get update && apt-get install -y curl openjdk-7-jdk git && \
    curl -sSLO 'http://apache.mirrors.ovh.net/ftp.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz' && \
    tar -zxf apache-maven-3.3.9-bin.tar.gz && \
    mv apache-maven-3.3.9 /opt/maven && \
    rm apache-maven-3.3.9-bin.tar.gz && \
    git config --system http.sslVerify false && \
    pip3 install requests && \
    ln -s /usr/local/bin/python3 /usr/bin && \
    apt-get remove -y curl && \
    apt-get autoclean && apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64
ENV PATH /usr/lib/jvm/java-7-openjdk-amd64/bin:/opt/maven/bin:$PATH

ENV ARIANE_SOURCE_DIR /ECHINOPSII
ADD script/arianeBuildEnv.sh /

CMD /arianeBuildEnv.sh
