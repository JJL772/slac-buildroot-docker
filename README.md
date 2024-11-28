# slac-buildroot-docker

This repository contains Dockerized buildroot toolchains for use with SLAC's version of buildroot.

## Pulling

The containers can be obtained from GitHub's package registry as follows:

```
docker pull ghcr.io/jjl772/slac-buildroot:2019.08-x86_64
```

Replace the final bit (2019.08-x86_64) with any of the available versions and architectures:

| Container Tag | Buildroot Version | Architecture | Notes |
|---|---|---|---|
| 2019.08-x86_64 | buildroot-2019.08 | x86_64 | ATCA, Dell servers |
| 2019.08-i686 | buildroot-2019.08 | i686 (x86) | EMCOR magnet power supplies |
| 2019.08-zynq | buildroot-2019.08 | ARM | Test system on someone's desk, many years ago. |

NOTE: buildroot-2016.11.1 unsupported right now

## Using the Compilers

The buildroot paths within the container match what's found on S3DF. Thus, most SLAC software should be able to build out of the box regardless if there's hardcoded paths.

The top of the buildroot directory is located at `/sdf/sw/epics/package/linuxRT/buildroot-<version>`

For buildroot-2019.08 and x86_64, GCC would be at: `/sdf/sw/epics/package/linuxRT/buildroot-2019.08/host/linux-x86_64/x86_64/bin/x86_64-buildroot-linux-gnu-gcc`

## Building and Using Images

First, create the container (i.e. for i686):
```
./create-container.sh -a i686
```

Use `get-images.sh` to extract the images from the container:
```
./get-images.sh -t 2019.08 -t 2019.08-i686
```

The resulting images will be in `images/buildroot-2019.08-i686`.

## Development

`Dockerfile.dev` defines a development container that can be used to compile the buildroot images. Due to the age of these images, they generally will not compile on modern Linux distros, but they will build in
this container (which is Fedora 30). They should also build Rocky 9/RHEL9

To bootstrap a development container run `./start-dev-container.sh`. This will build the docker image and launch the container under the name slac-buildroot-dev-container. The container mounts
this directory as a volume, and the resulting build will be in the buildroot directory.

To run commands in this container, run `./run-docker-cmd.sh mycommand and stuff`.

For example, to build the container you would run `./run-docker-cmd.sh ./buildroot/setup.sh`
