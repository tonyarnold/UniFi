FROM debian:jessie
MAINTAINER Tony Arnold <tony@thecocoabots.com>

ENV DEBIAN_FRONTEND noninteractive

# Update and install the required software
RUN echo "deb http://www.ubnt.com/downloads/unifi/debian unifi5 ubiquiti" > \
  /etc/apt/sources.list.d/20ubiquiti.list && \
  echo "deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen" > \
  /etc/apt/sources.list.d/21mongodb.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50 && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10

RUN apt-get -q update && \
  apt-get install -qy --force-yes wget unifi && \
  apt-get -q clean && \
  rm -rf /var/lib/apt/lists/*

# Install beta version of controller software
ADD https://www.ubnt.com/downloads/unifi/5.0.7-1d8af2d8/unifi_sysvinit_all.deb /tmp/unifi_sysvinit_all.deb
RUN dpkg -i /tmp/unifi_sysvinit_all.deb && rm /tmp/unifi_sysvinit_all.deb

# Wipe out auto-generated data
RUN rm -rf /var/lib/unifi/*

# Expose ports, and set working directory
EXPOSE 3478/udp 8080/tcp 8081/tcp 8443/tcp 8843/tcp 8880/tcp
VOLUME /var/lib/unifi
WORKDIR /var/lib/unifi

# Start the UniFi controller process
ENTRYPOINT ["/usr/bin/java", "-Xmx1024M", "-jar", "/usr/lib/unifi/lib/ace.jar"]
CMD ["start"]
