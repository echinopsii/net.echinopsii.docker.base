FROM echinopsii/fedora.21.systemd

MAINTAINER Mathilde Ffrench <mathilde.ffrench@echinopsii.net>

ENV JAVA_HOME /opt/java/jdk1.7.0_75
ENV PATH $JAVA_HOME/bin:$PATH

RUN yum -y update && yum clean all && \
  yum -y install pwgen wget net-tools bind-utils unzip tar && yum clean all && \
  mkdir -p /opt/java/ && \
  curl -LO 'http://download.oracle.com/otn-pub/java/jdk/7u75-b13/jdk-7u75-linux-x64.tar.gz' -H 'Cookie: oraclelicense=accept-securebackup-cookie' && \
  tar zxvf jdk-7u75-linux-x64.tar.gz && \
  mv jdk1.7.0_75 /opt/java/ && \
  rm jdk-7u75-linux-x64.tar.gz && \
  mkdir -p /opt/ariane/tradeworkflow && \
  curl -L http://nexus.echinopsii.net/nexus/content/groups/public/net/echinopsii/ariane/community/scenarios/net.echinopsii.ariane.community.scenarios.distrib/0.3.0-SNAPSHOT/net.echinopsii.ariane.community.scenarios.distrib-0.3.0-20160912.000255-31.zip > net.echinopsii.ariane.community.scenarios.distrib-0.3.0-SNAPSHOT.zip && \
  unzip net.echinopsii.ariane.community.scenarios.distrib-0.3.0-SNAPSHOT.zip && \
  mv net.echinopsii.ariane.community.scenarios.distrib-0.3.0-SNAPSHOT/distrib /opt/ariane/tradeworkflow/ && \
  rm net.echinopsii.ariane.community.scenarios.distrib-0.3.0-SNAPSHOT.zip && \
  rm -rf net.echinopsii.ariane.community.scenarios.distrib-0.3.0-SNAPSHOT && \
  chmod 755 /opt/ariane/tradeworkflow/distrib/bin/*.sh

CMD ["/usr/sbin/init"]
