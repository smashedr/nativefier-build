Write-Host "PATH:          $Env:PATH"
Write-Host "WORKSPACE:     $Env:WORKSPACE"
Write-Host "app_name:      $Env:app_name"
Write-Host "app_url:       $Env:app_url"
Write-Host "favicon_url:   $Env:favicon_url"

$favicon = $Env:favicon_url.split('/')[-1]

Write-Host "favicon:       $favicon"
Write-Host "icon ext:      $favicon.split('.')[-1]"

nativefier -V
python -V
magick.exe -version

if ("$favicon.split('.')[-1]" -ne "png") {
    magick.exe convert "$favicon" "favicon.png"
}
