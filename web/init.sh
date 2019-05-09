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
DEBIAN_FRONTEND=noninteractive apt -y install --no-install-recommends less nano wget ca-certificates xz-utils git python

su - c
wget https://nodejs.org/dist/v11.14.0/node-v11.14.0-linux-x64.tar.xz
tar xvf node-v11.14.0-linux-x64.tar.xz
rm node-v11.14.0-linux-x64.tar.xz

echo "export PATH=$PATH:/home/c/node-v11.14.0-linux-x64/bin" >> .bashrc
EOT

cp -Rp web bootstrap/home/c
