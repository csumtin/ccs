#!/bin/bash
set -eux

sudo systemd-nspawn -D bootstrap -u c -M web
