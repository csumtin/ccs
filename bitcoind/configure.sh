#!/bin/bash
set -eux

systemd-nspawn -D bootstrap /bin/bash <<EOT
DEBIAN_FRONTEND=noninteractive apt -y install --no-install-recommends wget ca-certificates procps

su - c

wget https://bitcoin.org/bin/bitcoin-core-0.17.1/bitcoin-0.17.1-x86_64-linux-gnu.tar.gz
tar xvf bitcoin-0.17.1-x86_64-linux-gnu.tar.gz
rm bitcoin-0.17.1-x86_64-linux-gnu.tar.gz
EOT
