$ErrorActionPreference = "Stop"

Write-Host "PATH:          $Env:PATH"
Write-Host "WORKSPACE:     $Env:WORKSPACE"
Write-Host "app_name:      $Env:app_name"
Write-Host "app_url:       $Env:app_url"
Write-Host "favicon_url:   $Env:favicon_url"
Write-Host "window_width:  $Env:window_width"
Write-Host "window_height: $Env:window_height"
Write-Host "extra_args:    $Env:extra_args"

$favicon = $Env:favicon_url.split('/')[-1]
$ext = $favicon.split('.')[-1]

Write-Host "favicon:       $favicon"
Write-Host "icon ext:      $ext"

Invoke-WebRequest -Uri "$Env:favicon_url" -OutFile ".\$favicon"

if ("$ext" -ne "png") { magick convert -resize 128x128 ".\$favicon[0]" ".\favicon.png" }

nativefier --name "$Env:app_name" --icon ".\favicon.png" --width "$Env:window_width" --height "$Env:window_height" --user-agent "$Env:app_name (electron)" $Env:extra_args "$Env:app_url"
if ($LastExitCode -ne 0) { Throw "nativefier exited with error code: $LastExitCode" }

$archive = $Env:app_name.Replace(" ","-") + ".zip"
$exe = $Env:app_name + ".exe"

7z.exe a ".\$archive" ".\$Env:app_name-win32-x64"
if ($LastExitCode -ne 0) { Throw "7z.exe exited with error code: $LastExitCode" }
