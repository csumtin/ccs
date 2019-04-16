#!/bin/bash
set -eux

sudo systemd-nspawn -D bootstrap -u c -M vpn --capability=CAP_NET_ADMIN
