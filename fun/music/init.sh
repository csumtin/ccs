#!/bin/bash
set -eux

# make sure we are in ccs directory
cd "$(dirname "$0")"

if [[ $EUID -ne 0  ]]; then
  echo "This script must be run as root"
  exit 1
fi

mkdir bootstrap

debootstrap --arch=amd64 --variant=minbase stable bootstrap

echo "Pick root password"
systemd-nspawn -D bootstrap passwd

echo "Add user c and pick password"
systemd-nspawn -D bootstrap adduser c

systemd-nspawn -D bootstrap /bin/bash <<EOT
DEBIAN_FRONTEND=noninteractive apt -y install --no-install-recommends git ca-certificates nano python wget ffmpeg

su - c

wget https://github.com/ytdl-org/youtube-dl/releases/download/2020.03.24/youtube-dl
chmod +x youtube-dl

mkdir download

echo '#!/bin/bash
set -eu

mkdir -p download

while read line; do
    line_formated=${line// /_}
    if [ ! -f download/$line_formated.* ]; then
        ./youtube-dl -f bestaudio --limit-rate 450k --extract-audio --max-filesize 10m --min-views 200 --add-metadata -o "download/$line_formated.%(ext)s" "ytsearch:$line_formated"
    fi
done < $1' > getSongs.sh

echo '#!/bin/bash
set -eu

# put song title and artist on same line
cat soundcloud.csv | paste -d ' ' - -' > soundcloud.sh

echo '#!/bin/bash
set -eu

# convert csv to title-artist format
IFS=","
sed 1,1d spotify_playlist.csv |  while read spotify_uri track_name artist_name other; do echo $track_name-$artist_name | tr -d \"; done' > spotify.sh

chmod +x getSongs.sh soundcloud.sh spotify.sh

EOT
