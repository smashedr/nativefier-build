#!/usr/bin/env bash

set -e

echo "PATH:          ${PATH}"
echo "WORKSPACE:     ${WORKSPACE}"
echo "app_name:      ${app_name}"
echo "app_url:       ${app_url}"
echo "favicon_url:   ${favicon_url}"
echo "window_width:  ${window_width}"
echo "window_height: ${window_height}"

nativefier -V
convert --version

favicon=$(basename "$favicon_url")
wget "$favicon_url"

if [  "${favicon##*.}" != "png" ];then
    convert -resize 128x128 "./${favicon}[0]" "./favicon.png"
    favicon="favicon.png"
fi

echo "${favicon}"

nativefier --name "${app_name}" --icon "./${favicon}" --width "${window_width}" --height "${window_height}" --user-agent "${app_name} (electron)" "${app_url}"
