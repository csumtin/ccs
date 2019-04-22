#!/bin/bash
set -eux

sudo systemd-nspawn -b -D bootstrap -M printer
