Write-Host "PATH:          $Env:PATH"
Write-Host "WORKSPACE:     $Env:WORKSPACE"
Write-Host "app_name:      $Env:app_name"
Write-Host "app_url:       $Env:app_url"
Write-Host "favicon_url:   $Env:favicon_url"

$favicon = $Env:favicon_url.split('/')[-1]
$ext = $favicon.split('.')[-1]

Write-Host "favicon:       $favicon"
Write-Host "icon ext:      $ext"

nativefier -V
python -V
magick.exe -version

Invoke-WebRequest -Uri "$Env:favicon_url" -OutFile ".\$favicon"

if ("$ext" -ne "png") {
    magick.exe convert -resize 128x128 ".\$favicon[0]" ".\favicon.png"
}
