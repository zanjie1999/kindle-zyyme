#!/bin/sh

export LANG=C.UTF-8
export LC_ALL=C.UTF-8
export LC_CTYPE=C.UTF-8

PLUGIN_DIR=/mnt/us/extensions/screenshotMove
IMAGES_DIR=/mnt/us/images
MENU_FILE="$PLUGIN_DIR/menu.json"
TMP_FILE="$MENU_FILE.tmp"
UTF8_ENV="LANG=C.UTF-8 LC_ALL=C.UTF-8 LC_CTYPE=C.UTF-8"

json_escape() {
	printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g'
}

shell_quote() {
	printf '"%s"' "$(printf '%s' "$1" | sed 's/["\\`$]/\\&/g')"
}

write_item() {
	if [ "$need_comma" -eq 1 ]; then
		printf ',\n'
	fi

	name=$(json_escape "$1")
	priority=$2
	action=$(json_escape "$3")

	printf '        {"name": "%s", "priority": %s, "exitmenu": false, "refresh": true, "checked": true, "action": "%s"}' "$name" "$priority" "$action"
	need_comma=1
}

{
	printf '{\n'
	printf '  "items": [\n'
	printf '    {\n'
	printf '      "name": "截图移动",\n'
	printf '      "priority": -1,\n'
	printf '      "exitmenu": false,\n'
	printf '      "items": [\n'

	need_comma=0
	write_item "刷新列表" 1 "$UTF8_ENV sh $PLUGIN_DIR/refresh.sh >/dev/null 2>&1"

	priority=2
	mkdir -p "$IMAGES_DIR"
	for dir in "$IMAGES_DIR"/*; do
		if [ -d "$dir" ]; then
			target_name=${dir##*/}
			target_arg=$(shell_quote "$target_name")
			write_item "$target_name" "$priority" "$UTF8_ENV sh $PLUGIN_DIR/move.sh $target_arg >/dev/null 2>&1"
			priority=$((priority + 1))
		fi
	done

	printf '\n'
	printf '      ]\n'
	printf '    }\n'
	printf '  ]\n'
	printf '}\n'
} > "$TMP_FILE"

mv "$TMP_FILE" "$MENU_FILE"
