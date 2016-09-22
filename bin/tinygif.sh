#!/usr/bin/env bash
# From blog.pkh.me/p/21-high-quality-gif-with-ffmpeg.html
# Creates a high quality gif using a custom colour palette
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 myvideo.mp4"
    echo "Make sure your video is already cropped"
    exit
fi
myvideo=$1
filename="${myvideo%.*}"
palette="/tmp/palette.png"
filters="fps=10,scale=500:-1:flags=lanczos,setpts=0.5*PTS"
ffmpeg -v warning -i $myvideo -vf "$filters,palettegen" -y $palette
ffmpeg -v warning -i $myvideo -i $palette -lavfi "$filters [x]; [x][1:v] paletteuse" -y $filename.gif
#  75  ffmpeg -i ~/Desktop/HEARTS.mp4 -filter:v "fps=10,scale=300:-1,setpts=0.5*PTS" ~/Desktop/tiny-hearts.mp4
#  76  ./togif.sh 300 ~/Desktop/tiny-hearts.mp4 Desktop/tiny-hearts.gif
