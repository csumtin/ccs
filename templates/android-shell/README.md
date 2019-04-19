# Android-Shell
* run `lsusb`, example output:
```
Bus 004 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub
Bus 004 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 003 Device 003: ID 5986:02d2 Acer, Inc 
Bus 003 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 002: ID 22b8:2e81 Motorola PCS 
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```
* so our Motorola is on Bus001 and Device002, change `start.sh` to `--property='DeviceAllow=/dev/bus/usb/001/002 rw'`
* as root, go to /home/c/platform-tools
