FROM ubuntu:bionic
LABEL maintainer="Tony Arnold <tony@thecocoabots.com>"

ARG DEBIAN_FRONTEND=noninteractive

ENV UBUNTU_CODENAME=bionic
ENV PKGURL=https://dl.ubnt.com/unifi/5.10.20-b06c46ec1d/unifi_sysvinit_all.deb
ENV MONGODB_VERSION=3.4
ENV MONGODB_UBUNTU=xenial
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

RUN apt-get -q update && \
  apt-get install -qy gnupg wget curl && \
  apt-get -q clean

# Update and install the required software
RUN echo "deb https://www.ubnt.com/downloads/unifi/debian unifi5 ubiquiti" > \
  /etc/apt/sources.list.d/20ubiquiti.list && \
  echo "deb https://repo.mongodb.org/apt/ubuntu ${MONGODB_UBUNTU}/mongodb-org/${MONGODB_VERSION} multiverse" > \
  /etc/apt/sources.list.d/21mongodb-org-${MONGODB_VERSION}.list && \
  echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu ${UBUNTU_CODENAME} main" > \
  /etc/apt/sources.list.d/22webupd8team-java.list && \
  echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu ${UBUNTU_CODENAME} main" > \
  /etc/apt/sources.list.d/23webupd8team-java-src.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50 && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv EEA14886 && \
  wget -qO- https://www.mongodb.org/static/pgp/server-${MONGODB_VERSION}.asc | apt-key add

RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

RUN apt-get -q update && \
  apt-get --allow-unauthenticated install -qy oracle-java8-installer oracle-java8-set-default unifi && \
  apt-get -q clean && \
  rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV JAVA8_HOME /usr/lib/jvm/java-8-oracle

# Install beta version of controller software
ADD "${PKGURL}" /tmp/unifi_sysvinit_all.deb
RUN dpkg -i /tmp/unifi_sysvinit_all.deb && rm /tmp/unifi_sysvinit_all.deb

# Wipe out auto-generated data
RUN rm -rf /usr/lib/unifi/data

# Expose ports, and set working directory
EXPOSE 3478/udp 8080/tcp 8081/tcp 8443/tcp 8843/tcp 8880/tcp
VOLUME /usr/lib/unifi/data
WORKDIR /usr/lib/unifi/data

# Start the UniFi controller process
ENTRYPOINT ["/usr/lib/jvm/java-8-oracle/jre/bin/java", "-Xmx1024M", "-jar", "/usr/lib/unifi/lib/ace.jar"]
CMD ["start"]
