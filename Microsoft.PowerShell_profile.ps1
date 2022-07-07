import-module oh-my-posh
Set-PoshPrompt jandedobbeleer
Import-Module PSReadLine
Set-PSReadLineOption -EditMode Windows

$data  = (invoke-restmethod https://www.reddit.com/r/worldnews/.rss).title 
$index = 0
($data | ForEach-Object { "{0} - /xx\ - {1}" -f ($index++).ToString(" 00") , $_ })
"`n"
echo 	" 1.Bitübertragung 2.Sicherung 3.Vermittlung 4.Transport 5.Sitzung 6.Darstellung  7.Anwendungen", 
	" 1.Physical       2.Data Link 3.Network     4.Transport 5.Session 6.Presentation 7.Application"
"`n"
echo    " -Imperative                                      -Deklarative",
        " -Strukturierte -Prozedurale -Objektorientierte   -Funktionale -Logische"
"`n"
