#!/bin/bash
set -eux

systemd-nspawn -D bootstrap /bin/bash <<EOT
DEBIAN_FRONTEND=noninteractive apt -y install --no-install-recommends wget ca-certificates procps unzip autoconf automake build-essential git libtool libgmp-dev libsqlite3-dev python python3 net-tools zlib1g-dev libsodium-dev

su - c

wget https://bitcoin.org/bin/bitcoin-core-0.17.1/bitcoin-0.17.1-x86_64-linux-gnu.tar.gz
tar xvf bitcoin-0.17.1-x86_64-linux-gnu.tar.gz
rm bitcoin-0.17.1-x86_64-linux-gnu.tar.gz

echo "export PATH=$PATH:/home/c/bitcoin-0.17.1/bin" >> .bashrc

wget https://github.com/ElementsProject/lightning/releases/download/v0.7.0/clightning-v0.7.0.zip
unzip clightning-v0.7.0.zip
rm clightning-v0.7.0.zip

cd cilightning-v0.7.0
./configure
make
EOT
