#!/bin/bash
set -eux

systemd-nspawn -D bootstrap /bin/bash <<EOT
DEBIAN_FRONTEND=noninteractive apt -y install --no-install-recommends wget ca-certificates unzip systemd-sysv usbutils udev

wget https://raw.githubusercontent.com/M0Rf30/android-udev-rules/master/51-android.rules
mkdir -p /etc/udev/rules.d
mv 51-android.rules /etc/udev/rules.d

usermod -a -G plugdev c
usermod -a -G adbusers c

su - c
wget https://dl.google.com/android/repository/platform-tools-latest-linux.zip
unzip platform-tools-latest-linux.zip
rm platform-tools-latest-linux.zip
EOT
