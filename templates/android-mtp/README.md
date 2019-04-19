# Android-MTP
* change android device to transfer files mode
* `mtp-detect`, example output:
```
libmtp version: 1.1.13

Listing raw device(s)
Device 0 (VID=22b8 and PID=2e82) is a Motorola Moto G (ID2).
   Found 1 device(s):
   Motorola: Moto G (ID2) (22b8:2e82) @ bus 3, dev 6
```
* add bus 3 and dev 6, `--property='DeviceAllow=/dev/bus/usb/003/006 rw'`
* `mkdir mountPoint`
* `jmtpfs mountPoint`
* umount with `fusermount -u mountPoint` as root
