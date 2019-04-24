FROM alpine:3.7
LABEL maintainer="Tony Arnold <tony@thecocoabots.com>"

ENV PKGURL=https://dl.ubnt.com/unifi/5.11.18-996baf2ca5/UniFi.unix.zip

RUN apk add --no-cache mongodb~=3.4
RUN apk add --no-cache openjdk8
RUN apk add --no-cache unzip

ENV JAVA_HOME /usr/lib/jvm/default-jvm
ENV JAVA8_HOME /usr/lib/jvm/default-jvm

# Install beta version of controller software
ADD "${PKGURL}" /tmp/UniFi.unix.zip
WORKDIR /usr/lib/
RUN unzip /tmp/UniFi.unix.zip
RUN mv UniFi unifi
RUN rm /usr/lib/unifi/bin/mongod
RUN ln -s /usr/bin/mongod /usr/lib/unifi/bin/mongod

# Wipe out auto-generated data
RUN rm -rf /usr/lib/unifi/data

# Expose ports, and set working directory
EXPOSE 3478/udp 8080/tcp 8081/tcp 8443/tcp 8843/tcp 8880/tcp
VOLUME /usr/lib/unifi/data
WORKDIR /usr/lib/unifi/data

# Start the UniFi controller process
ENTRYPOINT ["/usr/lib/jvm/default-jvm/jre/bin/java", "-Xmx1024M", "-jar", "/usr/lib/unifi/lib/ace.jar"]
CMD ["start"]
