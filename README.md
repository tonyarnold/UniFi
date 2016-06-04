![UniFi Controller Software screenshot](https://ubcdn.co/static/images/enterprise/software/heroDevices2X.jpg)

# UniFi Controller

Docker container for [UniFi Controller](https://www.ubnt.com/enterprise/software/) (by [Ubiquiti Networks](https://www.ubnt.com)).

## Usage

```sh
docker run --restart=always -d \
           --name=unifi \
           --net=host \
           -v $PATH_TO_UNIFI_DIR:/var/lib/unifi \
           tonyarnold/unifi
```
