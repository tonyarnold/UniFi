FROM debian:jessie
MAINTAINER Tony Arnold <tony@thecocoabots.com>

VOLUME ["/var/lib/unifi", "/var/log/unifi", "/var/run/unifi", "/usr/lib/unifi/work"]

ENV DEBIAN_FRONTEND noninteractive

RUN /bin/bash -c "Scripts/install_unifi_controller.sh"
RUN ln -s /var/lib/unifi /usr/lib/unifi/data
EXPOSE 8080/tcp 8081/tcp 8443/tcp 8843/tcp 8880/tcp 3478/udp

# RUN chown -R nobody.nogroup /usr/lib/unifi && \
#     chown -R nobody.nogroup /var/lib/unifi && \
#     chown -R nobody.nogroup /var/log/unifi && \
#     chown -R nobody.nogroup /var/run/unifi

# USER nobody

WORKDIR /var/lib/unifi

ENTRYPOINT ["/usr/bin/java", "-Xmx1024M", "-jar", "/usr/lib/unifi/lib/ace.jar"]
CMD ["start"]
