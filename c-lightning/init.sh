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
DEBIAN_FRONTEND=noninteractive apt -y install --no-install-recommends wget ca-certificates procps unzip autoconf automake build-essential git libtool libgmp-dev libsqlite3-dev python python3 net-tools zlib1g-dev libsodium-dev

su - c

wget https://bitcoin.org/bin/bitcoin-core-0.17.1/bitcoin-0.17.1-x86_64-linux-gnu.tar.gz
tar xvf bitcoin-0.17.1-x86_64-linux-gnu.tar.gz
rm bitcoin-0.17.1-x86_64-linux-gnu.tar.gz

echo 'export PATH=$PATH:/home/c/bitcoin-0.17.1/bin' >> .bashrc

wget https://github.com/ElementsProject/lightning/releases/download/v0.7.0/clightning-v0.7.0.zip
unzip clightning-v0.7.0.zip
rm clightning-v0.7.0.zip

cd clightning-v0.7.0
./configure
make
EOT
