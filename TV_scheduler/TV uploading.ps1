# Create xml doc - assumes your xml is file E:\Scratch\test.xml
# If it's already in a variable, use $xml = [xml]$myVariable

$xml = [xml](Get-Content .\Scheduler.xml)

$date =  "{0:yyyyMMdd}" -f [datetime](get-date).adddays(-10)
#$date = $date, $date
$range = $xml.createelement("RANGE")
$t = $xml.createelement("CONTINUOUS")
$t.innertext = "1"
$range.appendchild($t)
$t = $xml.createelement("VALUE")
$t.innertext = $date
$date =  "{0:yyyyMMdd}" -f [datetime](get-date).adddays(-3)
$range.appendchild($t)
$t = $xml.createelement("VALUE")
$t.innertext = $date
$range.appendchild($t)

$xml.BATCH.attributes.attribute.RemoveChild($xml.BATCH.attributes.attribute.range)
$xml.BATCH.attributes.attribute.appendchild($range)

$s = (Get-Item -Path ".\" -Verbose).FullName
$xml.Save($s+"\test.xml")


C:\Mars30\PaloMARS2\PALOMARS.exe /batch:"test.xml" /ds:"Russia Map Orbita (01/2008..)" /log:"batch.log"

Start-Sleep -s 30

$newname = "AVITO TV event level "+("{0:yyyyMMdd}" -f [datetime](get-date).adddays(-4))+".xls"
Rename-Item -Path ".\Result\Simple.xls" -NewName $newname

$dir = "./TV_event_data"
$server = "russia.mecglobal.com"
$filelist = "./Result/"+$newname
$user = ""
$password = ""

"open $server
user $user $password
binary  
cd $dir     
" +
($filelist | %{ "put ""$_""`n" }) | ftp -i -in