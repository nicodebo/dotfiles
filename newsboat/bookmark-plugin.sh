#!/bin/sh
# this is a simple example script that demonstrates how bookmarking plugins for newsbeuter are implemented
# (c) 2007 Andreas Krennmair
# (c) 2016 Alexander Batischev

url="$1"
title="$2"
description="$3"
feed_title="$4"

data_dir=${XDG_DATA_HOME:-$HOME/.local/share}
mkdir -p "${data_dir}/newsboat"

echo -e "${url}\t${title}\t${description}\t${feed_title}" >> "${data_dir}/newsboat/bookmarks.txt"
