#!/bin/sh

# Kindle inage view
# zyyme 240201

sleep 1
seek=$(cat /tmp/imgView)
[ -z "$seek" ] && seek=0
seek=$(($seek $1 1))
files=$(ls -tr /mnt/us/screenshot/* /mnt/us/screenshot_*)
flen=$(echo "$files" | wc -l)
([ $seek -gt $flen ] || [ $seek -lt 1 ]) && seek=1
echo $seek > /tmp/imgView

eips -g `echo "$files" | tail -n $seek | head -n 1`

