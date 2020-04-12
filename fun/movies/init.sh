#!/bin/bash
set -eux

# make sure we are in ccs directory
cd "$(dirname "$0")"

if [[ $EUID -ne 0  ]]; then
  echo "This script must be run as root"
  exit 1
fi

mkdir bootstrap

debootstrap --arch=amd64 --variant=minbase stable bootstrap

echo "Pick root password"
systemd-nspawn -D bootstrap passwd

echo "Add user c and pick password"
systemd-nspawn -D bootstrap adduser c

systemd-nspawn -D bootstrap /bin/bash <<EOT
DEBIAN_FRONTEND=noninteractive apt -y install --no-install-recommends wget ca-certificates xz-utils pulseaudio libnss3 libgtk2.0-0 libxss1 libgconf-2-4

su - c
wget https://get.popcorntime.sh/build/Popcorn-Time-0.3.10-Linux-64.tar.xz
tar xvf Popcorn-Time-0.3.10-Linux-64.tar.xz
EOT
