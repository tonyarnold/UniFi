#!/bin/bash

if [[ "$UNIFI_URL"]; then
    apt-get update && apt-get install -y wget
    wget "$UNIFI_URL" --output-document=/tmp/unifi-controller.deb
    dpkg -i /tmp/unifi-controller.deb
    rm /tmp/unifi-controller.deb
else
    echo "deb http://www.ubnt.com/downloads/unifi/debian unifi5 ubiquiti" > /etc/apt/sources.list.d/20ubiquiti.list
    echo "deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen" > /etc/apt/sources.list.d/21mongodb.list
    apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50
    apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10

    RUN apt-get -q update
    apt-get install -qy --force-yes unifi
    apt-get -q clean
    rm -rf /var/lib/apt/lists/*
fi
