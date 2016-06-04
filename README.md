![UniFi Controller Software screenshot](https://ubcdn.co/static/images/enterprise/software/heroDevices2X.jpg)

# UniFi Controller

Docker container for [UniFi Controller](https://www.ubnt.com/enterprise/software/) (by [Ubiquiti Networks](https://www.ubnt.com)).

## Usage

For released versions of the UniFi Controller, use the following:

```sh
docker run --restart=always -d \
           --name=unifi \
           --net=host \
           -v $PATH_TO_UNIFI_DIR/data:/var/lib/unifi \
           -v $PATH_TO_UNIFI_DIR/logs:/var/log/unifi \
           -v $PATH_TO_UNIFI_DIR/run:/var/run/unifi \
           -v $PATH_TO_UNIFI_DIR/work:/usr/lib/unifi/work \
           tonyarnold/unifi
```

To install a beta version of the UniFi Controller software, specify the `UNIFI_URL` environment variable:

```sh
docker run --restart=always -d \
           --name=unifi \
           --net=host \
           -e UNIFI_URL=$URL \
           -v $PATH_TO_UNIFI_DIR/data:/var/lib/unifi \
           -v $PATH_TO_UNIFI_DIR/logs:/var/log/unifi \
           -v $PATH_TO_UNIFI_DIR/run:/var/run/unifi \
           -v $PATH_TO_UNIFI_DIR/work:/usr/lib/unifi/work \
           tonyarnold/unifi
```
