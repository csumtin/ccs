# Music

## GetSongs
```
#!/bin/bash
set -eu

mkdir -p download

while read line; do
    line_formated=${line// /_}
    if [ ! -f download/$line_formated.* ]; then
        ./youtube-dl -f bestaudio --limit-rate 450k --extract-audio --max-filesize 10m --min-views 200 --add-metadata -o "download/$line_formated.%(ext)s" "ytsearch:$line_formated"
    fi
done < $1
```

## Soundcloud
* copy paste from web ui
```
#!/bin/bash
set -eu

# put song title and artist on same line
cat soundcloud.csv | paste -d ' ' - -'
```

## Spotify
* go to https://rawgit.com/watsonbox/exportify/master/exportify.html
* export csv
```
#!/bin/bash
set -eu

# convert csv to title-artist format
IFS=","
sed 1,1d spotify_playlist.csv |  while read spotify_uri track_name artist_name other; do echo $track_name-$artist_name | tr -d \"; done
```
