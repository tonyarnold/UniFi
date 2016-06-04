FROM debian:jessie
MAINTAINER Tony Arnold <tony@thecocoabots.com>

ENV DEBIAN_FRONTEND noninteractive

ADD https://www.ubnt.com/downloads/unifi/5.0.7-1d8af2d8/unifi_sysvinit_all.deb /tmp/unifi_sysvinit_all.deb
RUN dpkg -i /tmp/unifi_sysvinit_all.deb && rm /tmp/unifi_sysvinit_all.deb
RUN ln -s /var/lib/unifi /usr/lib/unifi/data

EXPOSE 8080/tcp 8081/tcp 8443/tcp 8843/tcp 8880/tcp 3478/udp
VOLUME ["/var/lib/unifi", "/var/log/unifi", "/var/run/unifi", "/usr/lib/unifi/work"]
WORKDIR /var/lib/unifi

ENTRYPOINT ["/usr/bin/java", "-Xmx1024M", "-jar", "/usr/lib/unifi/lib/ace.jar"]
CMD ["start"]
