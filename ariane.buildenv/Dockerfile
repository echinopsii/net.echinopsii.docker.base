FROM fedora:21	

MAINTAINER Laurent Bernaille <laurent.bernaille@echinopsii.net>

RUN yum -y update && yum clean all 
RUN yum -y install tar git 
RUN yum -y install python3 python3-pip
RUN pip3 install requests

RUN mkdir -p /opt/java/
RUN curl -LO 'http://download.oracle.com/otn-pub/java/jdk/7u75-b13/jdk-7u75-linux-x64.tar.gz' -H 'Cookie: oraclelicense=accept-securebackup-cookie'
RUN tar zxvf jdk-7u75-linux-x64.tar.gz
RUN mv jdk1.7.0_75 /opt/java/
RUN rm jdk-7u75-linux-x64.tar.gz

RUN curl -LO 'http://apache.mirrors.ovh.net/ftp.apache.org/dist/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz'
RUN tar zxvf apache-maven-3.3.3-bin.tar.gz
RUN mv apache-maven-3.3.3 /opt/maven
RUN rm apache-maven-3.3.3-bin.tar.gz

RUN git config --global http.sslVerify false

ENV JAVA_HOME /opt/java/jdk1.7.0_75
ENV PATH /opt/java/jdk1.7.0_75/bin:/opt/maven/bin:$PATH
