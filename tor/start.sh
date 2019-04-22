#!/bin/bash
set -eux

sudo systemd-nspawn -D bootstrap -u c -M tor --capability=CAP_NET_ADMIN
