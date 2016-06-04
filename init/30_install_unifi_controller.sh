#!/bin/bash

# opt out for autoupdates
[ "$ADVANCED_DISABLEUPDATES" ] && exit 0

export DEBIAN_FRONTEND=noninteractive

if [[ $UNIFI_URL ]]; then
    apt-get update && apt-get install -y wget
    wget "$UNIFI_URL" --output-document=/tmp/unifi-controller.deb
    dpkg -i /tmp/unifi-controller.deb
    rm /tmp/unifi-controller.deb
fi
