#!/bin/bash
set -eux

systemd-nspawn -D bootstrap /bin/bash <<EOT
DEBIAN_FRONTEND=noninteractive apt -y install --no-install-recommends less nano wget ca-certificates xz-utils git python

su - c
wget https://nodejs.org/dist/v11.14.0/node-v11.14.0-linux-x64.tar.xz
tar xvf node-v11.14.0-linux-x64.tar.xz
rm node-v11.14.0-linux-x64.tar.xz

echo "export PATH=$PATH:/home/c/node-v11.14.0-linux-x64/bin" >> .bashrc
EOT
