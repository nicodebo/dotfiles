#!/usr/bin/env bash

rem_file="${XDG_CONFIG_HOME}/remind/remind"
base_dir="/tmp/remind"
mkdir -p "$base_dir"
tmp_dir=$(mktemp -d -p "$base_dir")
remind "-krem_save $tmp_dir %s" "$rem_file" > /dev/null
# echo path so that the lua program can be aware of the directory
# echo "$tmp_dir"
ls -1 "$tmp_dir" | wc -l
