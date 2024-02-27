#!/bin/sh

# Kindle inage view
# zyyme 240201

seek=$(cat /tmp/imgView)
[ -z "$seek" ] && seek=0
seek=$(($seek $1 1))
files=$(find $2 -type f)
flen=$(echo "$files" | wc -l)
[ $seek -lt 1 ] && seek=$flen
[ $seek -gt $flen ] && seek=1
echo $seek > /tmp/imgView
fn=$(echo "$files" | tail -n $seek | head -n 1)
eips 1 1 $seek/$flen
# chinese -> ?
eips 0 0 "`echo $fn | xargs ls | sed 's/\/mnt\/us\///'`"
sleep 1
eips -w reagl -g "$fn"

