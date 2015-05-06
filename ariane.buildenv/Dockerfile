FROM python:slim

MAINTAINER Laurent Bernaille <laurent.bernaille@echinopsii.net>

RUN set -x && \
    apt-get update && apt-get install -y curl && \
    curl -sSLO 'http://download.oracle.com/otn-pub/java/jdk/7u80-b15/jdk-7u80-linux-x64.tar.gz' -H 'Cookie: oraclelicense=accept-securebackup-cookie' && \
    tar -zxf jdk-7u80-linux-x64.tar.gz && \
    mv jdk1.7.0_80 /opt/java && \
    rm jdk-7u80-linux-x64.tar.gz && \
    apt-get remove -y curl && \
    apt-get autoclean && apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN set -x && \
    apt-get update && apt-get install -y curl && \
    curl -sSLO 'http://apache.mirrors.ovh.net/ftp.apache.org/dist/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz' && \
    tar -zxf apache-maven-3.3.3-bin.tar.gz && \
    mv apache-maven-3.3.3 /opt/maven && \
    rm apache-maven-3.3.3-bin.tar.gz && \
    apt-get remove -y curl && \
    apt-get autoclean && apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN set -x && \
    apt-get update && apt-get install -y git && \
    apt-get autoclean && apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git config --system http.sslVerify false

RUN pip3 install requests
RUN ln -s /usr/local/bin/python3 /usr/bin

ENV JAVA_HOME /opt/java
ENV PATH /opt/java/bin:/opt/maven/bin:$PATH

ENV ARIANE_SOURCE_DIR /ECHINOPSII
ADD script/arianeBuildEnv.sh /

CMD /arianeBuildEnv.sh
