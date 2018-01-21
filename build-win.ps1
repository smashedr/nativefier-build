Write-Host "PATH:          $Env:PATH"
Write-Host "WORKSPACE:     $Env:WORKSPACE"
Write-Host "app_name:      $Env:app_name"
Write-Host "app_url:       $Env:app_url"
Write-Host "favicon_url:   $Env:favicon_url"

$favicon = $path.split('/')[-1]

Write-Host "favicon:       $favicon"

nativefier -V
python -V
convert -version
