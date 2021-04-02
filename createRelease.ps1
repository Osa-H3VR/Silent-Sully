$manifest = Get-Content .\manifest.json | ConvertFrom-Json
$deliName = $manifest.name+$manifest.version+".deli"
$deliZipName = $manifest.name+$manifest.version+".zip"
$zipName = "UnZipMePls-"+$manifest.name+$manifest.version+".zip"

#cleanup if anything is left behind
if (Test-Path $deliName) {
  Remove-Item $deliName
}
if (Test-Path $deliZipName) {
  Remove-Item $deliZipName
}
if (Test-Path $zipName) {
  Remove-Item $zipName
}

#create deli mod
Compress-Archive $manifest.name $deliZipName
Compress-Archive -Update "manifest.json" $deliZipName
Rename-Item $deliZipName $deliName

#create release package
Compress-Archive $deliName $zipName
Compress-Archive -Update "README.md" $zipName

Remove-Item $deliName
