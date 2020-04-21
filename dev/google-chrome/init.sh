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
DEBIAN_FRONTEND=noninteractive apt -y install --no-install-recommends wget ca-certificates

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

DEBIAN_FRONTEND=noninteractive apt -y install ./google-chrome-stable_current_amd64.deb

rm google-chrome-stable_current_amd64.deb
EOT
