# Echinopsii Cassandra 2.2 Base Image
#

FROM java:openjdk-8-jre

ENV DEBIAN_FRONTEND noninteractive
ENV CASSANDRA_CONFIG /etc/cassandra

ADD scripts/config-cassandra-base.sh /usr/local/bin/config-cassandra-base

RUN curl -L https://debian.datastax.com/debian/repo_key | apt-key add - && \
  echo "deb http://debian.datastax.com/datastax-ddc 3.7 main" | tee -a /etc/apt/sources.list.d/cassandra.sources.list && \
  ln -s -f /bin/true /usr/bin/chfn && \
  apt-get update && \
  apt-get install -y datastax-ddc && \
  rm -rf /var/lib/apt/lists/* && \
  /usr/local/bin/config-cassandra-base && \
  rm -f /etc/security/limits.d/cassandra.conf

EXPOSE 7199 7000 7001 9160 9042 22 8012 61621

CMD [""]
