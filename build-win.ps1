Write-Host "PATH:          $PATH"
Write-Host "WORKSPACE:     $WORKSPACE"
Write-Host "app_name:      $app_name"
Write-Host "app_url:       $app_url"
Write-Host "favicon_url:   $favicon_url"
Write-Host "appdmg_json    $appdmg_json"

$favicon = $path.split('/')[-1]

Write-Host "$favicon       $favicon"

nativefier -V
python -V
convert -version
