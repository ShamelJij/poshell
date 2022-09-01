function ex{exit}
new-alias sss ex
$nvimdir = 'C:\Users\IT_Admin\AppData\Local\nvim'
$inventar = 'C:\start\code\inventarComplete'
$start = 'c:\start'
Function goToVim {cd C:\Users\IT_Admin\AppData\Local\nvim}
Set-Alias -Name govim -Value goToVim
Function goToInventar {cd C:\start\code\inventarComplete}
Set-Alias -Name goinventar -Value goToInventar
Function goToStart {cd c:\start}
Set-Alias -Name gostart -Value goToStart
Function neov {nvim .}
set-Alias -Name n -Value neov
import-module posh-git 
Set-PoshPrompt cert
Import-Module PSReadLine
Set-PSReadLineOption -EditMode Windows
$mnews = (invoke-restmethod https://defence-blog.com/feed/).title
$index = 0
Function getMNews {write-output "`t {{Military News}} `n";($mnews | ForEach-Object { "{0}. {1}" -f ($index++ + 1).ToString(" 00") , $_ })}
Set-Alias -Name mnews -Value getMNews
$data  = (invoke-restmethod https://www.reddit.com/r/worldnews/.rss).title 
$index = 0
($data | ForEach-Object { "{0}. {1}" -f ($index++ + 1).ToString(" 00") , $_ })
$index = 0
Function getNews {echo "`t {{World News}} `n"; ($data | ForEach-Object { "{0}. {1}" -f ($index++ + 1).ToString(" 00") , $_ })}
Set-Alias -Name news -Value getNews
echo 	" 1.Bitübertragung 2.Sicherung 3.Vermittlung 4.Transport 5.Sitzung 6.Darstellung  7.Anwendungen", 
	" 1.Physical       2.Data Link 3.Network     4.Transport 5.Session 6.Presentation 7.Application"
echo    " -Imperative                                      -Deklarative",
        " -Strukturierte -Prozedurale -Objektorientierte   -Funktionale -Logische"
"`n"
