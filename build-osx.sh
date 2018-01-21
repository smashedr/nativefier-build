#!/usr/bin/env bash

set -e

export PATH="${PATH}:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

echo "PATH:          ${PATH}"
echo "WORKSPACE:     ${WORKSPACE}"
echo "app_name:      ${app_name}"
echo "app_url:       ${app_url}"
echo "favicon_url:   ${favicon_url}"
echo "window_width:  ${window_width}"
echo "window_height: ${window_height}"
echo "extra_args:    ${extra_args}"

which sips
which tiff2icns
nativefier -V
tar --version
wget -V

favicon=$(basename "$favicon_url")
wget "$favicon_url"

if [  "${favicon##*.}" != "icns" ] && [  "${favicon##*.}" != "tiff" ];then
    sips -s format tiff "./${favicon}" --out ./favicon.tiff
    favicon="favicon.tiff"
fi
if [  "${favicon##*.}" = "tiff" ];then
    tiff2icns -noLarge "./${favicon}" ./favicon.icns
    favicon="favicon.icns"
fi
if [  "${favicon##*.}" != "icns" ];then
    echo "Error creating favicon.icns"
    exit 1
fi

echo nativefier --name "${app_name}" --icon "./${favicon}" --width "${window_width}" --height "${window_height}" --user-agent "${app_name} (electron)" ${extra_args} "${app_url}"
out=$(nativefier --name "${app_name}" --icon "./${favicon}" --width "${window_width}" --height "${window_height}" --user-agent "${app_name} (electron)" ${extra_args} "${app_url}")
dir=$(echo "${out}" | tail -n1 | awk -F' to ' '{print $2}')
archive="$(echo ${app_name} | sed 's/ /-/g').tar.gz"

cd "${dir}"
tar -czf "${archive}" "${app_name}.app"
mv "${archive}" "${WORKSPACE}"
