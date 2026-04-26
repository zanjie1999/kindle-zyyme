#!/bin/sh

export LANG=C.UTF-8
export LC_ALL=C.UTF-8
export LC_CTYPE=C.UTF-8

US_DIR=/mnt/us
IMAGES_DIR="$US_DIR/images"
TARGET_NAME=${1-}

if [ -z "$TARGET_NAME" ]; then
	exit 1
fi

case "$TARGET_NAME" in
	.|..|*/*)
		exit 1
		;;
esac

TARGET_DIR="$IMAGES_DIR/$TARGET_NAME"
mkdir -p "$TARGET_DIR"
mv "$US_DIR"/screenshot_*.png "$TARGET_DIR"/

rm -f "$US_DIR"/wininfo_screenshot_*.txt
