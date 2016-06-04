FROM linuxserver/baseimage
MAINTAINER Tony Arnold <tony@thecocoabots.com>

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

RUN ln -s /var/lib/unifi /usr/lib/unifi/data
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
RUN chmod -v +x /etc/service/*/run /etc/my_init.d/*.sh

# Mappings and ports
VOLUME ["/var/lib/unifi", "/var/log/unifi", "/var/run/unifi", "/usr/lib/unifi/work"]
EXPOSE 8080/tcp 8081/tcp 8443/tcp 8843/tcp 8880/tcp 3478/udp
WORKDIR "/usr/lib/unifi/work"
