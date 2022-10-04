new-alias .. cd..
function ex{exit}
new-alias sss ex
new-alias lll cls
new-alias ll ls
Function gocode{cd C:\start\code\}
Function gopro {nvim $profile}
Function goInit {nvim C:\Users\IT_Admin\AppData\Local\nvim\init.vim}
Function showCode{cat $profile}
Function github{ start msedge https://github.com/ShamelJij}
Function google{ 
    $searchQuery = Read-Host "searching for? ";
    [string[]]$Q = $searchQuery.split(" ");
    $e = '';
    for($i=0; $i -lt $Q.length; $i++){
           $e += $Q[$i]+'+'  
        }
    echo $e;
    start msedge https://www.google.com/search?q=$e
    }
Function getfile{
                param(
                    $fileName
                )
                ls . -Recurse -File $fileName
                }
Function getDir{
                param(
                    $dirName
                )
                ls . -Recurse -Directory $dirName
                }
Function pushInit{ 
                    pushd C:\Users\IT_Admin\AppData\Local\nvim\
                    git add C:\Users\IT_Admin\AppData\Local\nvim\init.vim
                    git commit -m "new commit"
                    git push origin main
                    popd
                }                
Function newGit{
                    $remoteLink = Read-Host "past your remote link here please" 
                    git init
                    git add .
                    git commit -m "first commit"
                    git branch -M main
                    git remote add origin $remoteLink
                    git push -u origin main
                    
    }                
Function pushPro{ 
                    $commMsg = Read-Host "commit message for PowerShell_profile:"
                    pushd C:\Users\IT_Admin\Documents\WindowsPowerShell\
                    git add C:\Users\IT_Admin\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
                    git commit -m $commMsg 
                    git push origin daapc
                    popd
                }                
Function pushit{
                    $msg = Read-Host "enter your commit message"
                    git add .
                    git commit -m $msg 
                    git push origin main
                }

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
Function nd {neovide .}
Function goStartup {cd "C:\Users\IT_Admin\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"}
Function goroot {cd "C:\Users\IT_Admin\AppData\Local\Packages"}
Function goIdeavim {nvim "C:\Users\IT_Admin\.ideavimrc"}
Function goBookShop {cd "C:\start\code\bookshop\bookshop"}
import-module -Name Terminal-Icons
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

