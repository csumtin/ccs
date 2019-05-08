# Container System

## Setup
* Install `apt install --no-install-recommends debootstrap systemd-container sudo`
* Let c user sudo systemd-nspawn `echo "c	ALL=NOPASSWD:/usr/bin/systemd-nspawn" >> /etc/sudoers`

## Usage
* Every container folder has a `init.sh`, `configure.sh` and `start.sh`
* `init.sh` will create a new bootstrap folder containing the container, calling `configure.sh` to configure container
* `start.sh` will start and drop into container

