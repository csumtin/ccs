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
DEBIAN_FRONTEND=noninteractive apt -y install --no-install-recommends wget ca-certificates unzip pulseaudio libnss3 libgtk-3-0 libxss1 libgconf-2-4 libatspi2.0-0  libatomic1 libgl1-mesa-glx

su - c
wget https://get.popcorntime.app/repo/build/Popcorn-Time-0.4.4-linux64.zip
unzip Popcorn-Time-0.4.4-linux64.zip
EOT
