param([string]$id, [string]$savefolder = "C:\Users\mpavlov\Documents\", [string]$media)
$uri = "http://icreative.adfact.ru/web-service/?media="+$media+"&id="+$id+"&quality=m"
If ($media = 'TV') {$type = ".avi"}
If ($media = 'RA') {$type = ".wmw"}
If ($media = 'PR') {$type = ".jpg"}
If ($media = 'OD') {$type = ".jpg"}
If ($media = 'IN') {$type = ".jpg"}

$savefile = $savefolder+$id+$type
$securepassword = ConvertTo-SecureString "ei0nqrz2" -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential("mpavlov", $securepassword)

Invoke-WebRequest -Uri $uri -Credential $credentials -OutFile $savefile