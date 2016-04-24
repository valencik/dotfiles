#!/usr/bin/env bash
# From blog.pkh.me/p/21-high-quality-gif-with-ffmpeg.html
# Creates a high quality gif using a custom colour palette

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 myvideo.mp4 mygif.gif"
fi

palette="/tmp/palette.png"

filters="fps=15,scale=$1:-1:flags=lanczos"

ffmpeg -v warning -i $2 -vf "$filters,palettegen" -y $palette
ffmpeg -v warning -i $2 -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse" -y $3
