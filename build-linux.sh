#!/usr/bin/env bash

set -e

echo "PATH:          ${PATH}"
echo "WORKSPACE:     ${WORKSPACE}"
echo "app_name:      ${app_name}"
echo "app_url:       ${app_url}"
echo "favicon_url:   ${favicon_url}"
echo "window_width:  ${window_width}"
echo "window_height: ${window_height}"
echo "extra_args:    ${extra_args}"

nativefier -V
convert --version
tar --version
wget -V

favicon=$(basename "$favicon_url")
wget "$favicon_url"

if [  "${favicon##*.}" != "png" ];then
    convert -resize 128x128 "icon:favicon.ico[0]" favicon.png
    favicon="favicon.png"
fi

echo nativefier --name "${app_name}" --icon "./${favicon}" --width "${window_width}" --height "${window_height}" --user-agent "${app_name} (electron)" ${extra_args} "${app_url}"
out=$(nativefier --name "${app_name}" --icon "./${favicon}" --width "${window_width}" --height "${window_height}" --user-agent "${app_name} (electron)" ${extra_args} "${app_url}")
path=$(echo "${out}" | tail -n1 | awk -F' to ' '{print $2}')
dir=$(basename "${path}")

tar -czf "./${dir}.tar.gz" "./${dir}"
