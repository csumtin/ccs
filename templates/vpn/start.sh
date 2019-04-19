#!/bin/bash
set -eux

sudo systemd-nspawn -D bootstrap -M vpn --capability=CAP_NET_ADMIN
