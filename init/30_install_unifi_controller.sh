#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

if [[ $UNIFI_URL ]]; then
    echo "Installing UniFi Controller from $UNIFI_URL…"
    apt-get update && apt-get install -y wget
    wget "$UNIFI_URL" --output-document=/tmp/unifi-controller.deb
    dpkg -i /tmp/unifi-controller.deb
    rm /tmp/unifi-controller.deb
fi
