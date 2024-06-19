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
| 2019.08-zynq | buildroot-2019.08 | ARM (Xilinx Zynq 7000) | |

NOTE: buildroot-2016.11.1 unsupported right now

## Using the Compilers

The buildroot paths within the container match what's found on S3DF. Thus, most SLAC software should be able to build out of the box regardless if there's hardcoded paths.

The top of the buildroot directory is located at `/sdf/sw/epics/package/linuxRT/buildroot-<version>`

For buildroot-2019.08 and x86_64, GCC would be at: `/sdf/sw/epics/package/linuxRT/buildroot-2019.08/host/linux-x86_64/x86_64/bin/x86_64-buildroot-linux-gnu-gcc`
