FROM echinopsii/fedora.21.systemd

MAINTAINER Mathilde Ffrench <mathilde.ffrench@echinopsii.net>

RUN yum -y update && yum clean all
RUN yum -y install pwgen wget net-tools bind-utils unzip tar && yum clean all

RUN mkdir -p /opt/java/
RUN curl -LO 'http://download.oracle.com/otn-pub/java/jdk/7u75-b13/jdk-7u75-linux-x64.tar.gz' -H 'Cookie: oraclelicense=accept-securebackup-cookie'
RUN tar zxvf jdk-7u75-linux-x64.tar.gz
RUN mv jdk1.7.0_75 /opt/java/
RUN rm jdk-7u75-linux-x64.tar.gz

ENV JAVA_HOME /opt/java/jdk1.7.0_75
ENV PATH $JAVA_HOME/bin:$PATH

RUN mkdir -p /opt/ariane/tradeworkflow
RUN curl -L http://nexus.echinopsii.net/nexus/content/groups/public/net/echinopsii/ariane/community/scenarios/net.echinopsii.ariane.community.scenarios.distrib/0.3.0-SNAPSHOT/net.echinopsii.ariane.community.scenarios.distrib-0.3.0-20150717.134345-1.zip > net.echinopsii.ariane.community.scenarios.distrib-0.3.0-SNAPSHOT.zip
RUN unzip net.echinopsii.ariane.community.scenarios.distrib-0.3.0-SNAPSHOT.zip
RUN mv net.echinopsii.ariane.community.scenarios.distrib-0.3.0-SNAPSHOT/distrib /opt/ariane/tradeworkflow/
RUN rm net.echinopsii.ariane.community.scenarios.distrib-0.3.0-SNAPSHOT.zip
RUN rm -rf net.echinopsii.ariane.community.scenarios.distrib-0.3.0-SNAPSHOT
RUN chmod 755 /opt/ariane/tradeworkflow/distrib/bin/*.sh

CMD ["/usr/sbin/init"]
