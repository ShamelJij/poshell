new-alias .. cd..
new-alias dd cd
new-alias sss ex
new-alias cll cls
new-alias ll ls

$start = $env:myStart

Function ex {exit}
$timenow = ((get-date).ToString("yy-mm-dd-hh-mm-ss-tt"))
start-transcript -path $start\powershell\sessions\$timenow.txt -NoClobber
Function checknet {
	 Get-NetAdapter | select InterfaceDescription, name, Status, LinkSpeed
}

Function timehere{[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::Now,"W. Europe Standard Time")}
Function ustime{[System.TimeZoneInfo]::ConvertTimeBySystemTimeZoneId([DateTime]::Now,"US Eastern Standard Time")}
Function gomongo{cd "c:\program files\MongoDB\Server\6.0\bin\"}
Function gogo{cd $start\code\crudmongo\}
Function gosb{cd $start\code\springboot\}
Function goahk {cd $start\ahk}
Function goneovim {cd "C:\Program Files\Neovim"}
Function gocode{cd $start\code\}
Function goText{cd $start\code\ueben\text\}
Function gopro {nvim $profile}
Function gowt {nvim $home\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState}
Function goInit {nvim $home\AppData\Local\nvim}
Function showCode{cat $profile}
Function github{ start msedge https://github.com/ShamelJij}

#customPrompt

function Write-BranchName () {
    try {
        $branch = git rev-parse --abbrev-ref HEAD

        if ($branch -eq "HEAD") {
            # we're probably in detached HEAD state, so print the SHA
            $branch = git rev-parse --short HEAD
            Write-Host "$branch" -ForegroundColor "red"
        }
        else {
            # we're on an actual branch, so print it
            Write-Host "$branch" -ForegroundColor "cyan"
        }
    } catch {
        # we'll end up here if we're in a newly initiated git repo
        Write-Host "no branches yet" -ForegroundColor "yellow"
    }
}

function prompt {

    #Assing Branchname from the fucntion
    $branchName = Write-BranchName

    #Assign Windows Title Text
    $host.ui.RawUI.WindowTitle = "Current Folder: $pwd"

    #Configure current user, current folder and date outputs
    $CmdPromptCurrentFolder = Resolve-Path .
    $Date = Get-Date -Format 'dd.MM-hh:mm'


    #Calculate execution time of last cmd and convert to milliseconds, seconds or minutes
    $LastCommand = Get-History -Count 1
    if ($lastCommand) { $RunTime = ($lastCommand.EndExecutionTime - $lastCommand.StartExecutionTime).TotalSeconds }

    if ($RunTime -ge 60) {
        $ts = [timespan]::fromseconds($RunTime)
        $min, $sec = ($ts.ToString("mm\:ss")).Split(":")
        $ElapsedTime = -join ($min, " min ", $sec, " sec")
    }
    else {
        $ElapsedTime = [math]::Round(($RunTime), 2)
        $ElapsedTime = -join (($ElapsedTime.ToString()), " sec")
    }

    if (Test-Path .git) {
        #Decorate the CMD Prompt
        Write-Host "$CmdPromptCurrentFolder>" -ForegroundColor Green -NoNewline
        Write-Host "$date>$branchName" -ForegroundColor DarkCyan -NoNewline
    }
    else {
        # we're not in a repo so don't bother displaying branch name/sha
        #Decorate the CMD Prompt
        Write-Host "$CmdPromptCurrentFolder>" -ForegroundColor Green -NoNewline
        Write-Host "$date" -ForegroundColor DarkCyan -NoNewline
    }

}
#end prompt function
#this is only for eco project

Function goeco {cd $start\code\ecodaa\eco}
Function giteco {git clone https://github.com/ShamelJij/ecoref.git}
Function downup{docker compose -f docker-compose.yml down; cd ecoui; docker build -t docker101tutorial .; cd..; docker compose -f docker-compose.yml up -d}

Function addToast{
    param([string]$toastTitle="", [string]$toastDescription="", [datetime]$toastTime)
        if($toastTitle -eq ""){
            write-host 'this command will produce a toast notifications'
            $toastTitle = read-host 'Title'
            $toastDescription = read-host 'description'
            write-host 'now enter date. Example: "05/06/2022 11:05 AM". Press enter'
            $toastTimeString = read-host "Enter date and time"
            $toastTime = [datetime]::ParseExact($toastTimeString, 'MM/dd/yyyy hh:mm tt', $null);
            $toastDiff = (new-timespan -start (get-date) -end $toastTime)
            write-host "will start in", $toastDiff.hours, "hours and ", $toastDiff.minutes, "minutes";
            }
        $bildLocation = '$start\powershell\toast\toastIcon.png'
        $toastRandom = (Get-Random)
        $toastScript = '$start\powershell\toast\' + $toastRandom.tostring() + (($toastTimeString.replace(" ","-")).replace(":","-")).replace("/","-") + '.ps1'
New-Item -Path $toastScript;
$ToastContent =
'
#Specify Launcher App ID
$LauncherID = "{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe"

#Load Assemblies
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
[Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null

#Build XML Template
[xml]$ToastTemplate = @"
<toast>
    <visual>
        <binding template="ToastImageAndText03">
            <text id="1">$toastTitle</text>
            <text id="2">$toastDescription</text>
            <image id="1" src="$bildLocation" />
        </binding>
    </visual>
</toast>
"@

#Prepare XML
$ToastXml = [Windows.Data.Xml.Dom.XmlDocument]::New()
$ToastXml.LoadXml($ToastTemplate.OuterXml)

#Prepare and Create Toast
$ToastMessage = [Windows.UI.Notifications.ToastNotification]::New($ToastXML)
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($LauncherID).Show($ToastMessage)' | foreach-Object{$_ -replace '\$toastTitle', $toastTitle `
                                        -replace '\$toastDescription', $toastDescription ` -replace '\$bildLocation', $bildLocation `
                                        }| set-content $toastScript


        $toastTask = New-ScheduledTaskAction -Execute powershell.exe -Argument $toastScript
        $toastTrigger = New-ScheduledTaskTrigger -Once -At $toastTime
        Register-ScheduledTask -Action $toastTask -Trigger $toastTrigger -TaskName "$toastTitle_$toastRandom" -Description "$toastDescription"
    }

Function addtask{

    param([string]$taskTitle= "", [string]$taskDescription="", [datetime]$Time)

	if ($tasktitle -eq "") {
        write-host 'first enter title as a string. Also as (HTML). Press enter'
        $tasktitle = read-host "Enter task title here"
        write-host 'now enter the content of the message or the task description'
        $taskDescription= read-host "Enter task description here"
        write-host 'now enter date. Example: "05/06/2022 11:05 AM". Press enter'
        $TimeString = read-host "Enter date and time"
        $Time = [datetime]::ParseExact($TimeString, 'MM/dd/yyyy hh:mm tt', $null);
        write-host = "will start in " + (new-timespan -start (get-date) -end $Time)
    }
	$Random = (Get-Random)
    $destination_file = '$start\powershell\tasks\' + $Random.tostring() + (($TimeString.replace(" ","-")).replace(":","-")).replace("/","-") + '.html'
    write-host $destination_file
    ('<html>
        <head>
        <style>
            h1 {text-align: center;
                font-size: 200%;
                background-color: coral;}
            p {text-align: center;
                font-size: 200%;}
            </style>
        </head>
        <body>

        <h1>$tasktitle</h1>
        <p>$taskDescription</p>

        </body>
        </html>') | foreach-Object{$_ -replace '\$tasktitle', $tasktitle `
                                        -replace '\$taskDescription', $taskDescription `
                                        }| set-content $destination_file
    $arg = '$start\test2.html'
	$Task = New-ScheduledTaskAction -Execute powershell.exe -Argument "start msedge $destination_file"
	$Trigger = New-ScheduledTaskTrigger -Once -At $Time
	Register-ScheduledTask -Action $Task -Trigger $Trigger -TaskName "$tasktitle_$Random" -Description "$taskDescription"

    }

Function searchGithub {
    $searchGit = read-host "searching for";
    [string[]]$Qg = $searchGit.split(" ");
    $eg = '';
    for($ig=0; $ig -lt $Qg.length; $ig++){
           $eg += $Qg[$ig]+'+'
        }
    echo $eg;
    start msedge https://github.com/search?q=$eg

    }

Function google{
    $searchQuery = Read-Host "searching for";
    [string[]]$Q = $searchQuery.split(" ");
    $e = '';
    for($i=0; $i -lt $Q.length; $i++){
           $e += $Q[$i]+'+'
        }
    echo $e;
    start msedge https://www.google.com/search?q=$e
    }

Function youtube{
    $youtubeQuery = read-host "searching for";
    [string[]]$UQ = $youtubeQuery.split(" ");
    $ue = '';
    for($ui=0; $ui -lt $UQ.length; $ui++){
        $ue += $UQ[$ui]+'+'
    }
    echo $ue;
    start msedge https://www.youtube.com/results?search_query=$ue
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

Function addgitignore{
                git rm -rf --cached .
                Remove-Item -Path .vscode -Recurse
                set-content .gitignore '
                                        .vscode/*
                                        !.vscode/settings.json
                                        !.vscode/tasks.json
                                        !.vscode/launch.json
                                        !.vscode/extensions.json
                                        !.vscode/*.code-snippets

                                        # Local History for Visual Studio Code
                                        .history/

                                        # Built Visual Studio Code Extensions
                                        *.vsix'
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

Function pushahk{
                    pushd "$start\ahk\"
                    git add "$start\ahk\"
                    git commit -m $timenow
                    git push origin main
                    popd
                }
Function pushInit{
                    pushd $home\AppData\Local\nvim\
                    git add .
                    git commit -m $timenow
                    git push origin main
                    popd
                }

Function pushWT{
                    $commMsgWT = Read-Host "commit message for WindowsTerminal settings.json"
                    pushd $home\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\
                    git add $home\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
                    git commit -m $commMsgWT
                    git push origin daapc
                    popd
                }

Function pushPro{
                    $commMsg = Read-Host "commit message for PowerShell_profile"
                    pushd $start\powershell\profile
                    git add .
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

Function goodNight {
                    # load assembly System.Windows.Forms which will be used
                    Add-Type -AssemblyName System.Windows.Forms

                    # set powerstate to suspend (sleep mode)
                    $PowerState = [System.Windows.Forms.PowerState]::Suspend;

                    # do not force putting Windows to sleep
                    $Force = $false;

                    # so you can wake up your computer from sleep
                    $DisableWake = $false;
                    write-host 'good night to you too :]'
                    # do it! Set computer to sleep
                    [System.Windows.Forms.Application]::SetSuspendState($PowerState, $Force, $DisableWake);
                }

$nvimdir = '$home\AppData\Local\nvim'
$inventar = '$start\code\inventarComplete'
Function goToVim {cd $home\AppData\Local\nvim}
Set-Alias -Name govim -Value goToVim
Function goToInventar {cd $start\code\inventarComplete}
Set-Alias -Name goinventar -Value goToInventar
Function goToStart {cd $start}
Set-Alias -Name gostart -Value goToStart
Function neov {nvim .}
set-Alias -Name n -Value neov

Function nd {neovide .}
Function goStartup {cd "$home\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"}
Function goroot {cd "$home\AppData\Local\Packages"}
Function goIdeavim {nvim "$home\.ideavimrc"}
Function goBookShop {cd "$start\code\bookshop\bookshop"}

import-module -Name Terminal-Icons
import-module posh-git
# Set-PoshPrompt tokyo
# Import-Module PSReadLine
$timenow = ((get-date).ToString("yy-mm-dd-hh-mm-ss-tt"))
start-transcript -path $start\powershell\sessions\$timenow.txt -NoClobber
echo " `n"
Set-PSReadLineOption -EditMode Windows
# $mnews = (invoke-restmethod https://defence-blog.com/feed/).title
$index = 0
Function getMNews {write-output "`t {{Military News}} `n";($mnews | ForEach-Object { "{0}. {1}" -f ($index++ + 1).ToString(" 00") , $_ })}
Set-Alias -Name mnews -Value getMNews
$data  = (invoke-restmethod https://www.reddit.com/r/worldnews/.rss).title
$index = 0
$index = 0
Function getNews {echo "`t {{World News}} `n"; ($data | ForEach-Object { "{0}. {1}" -f ($index++ + 1).ToString(" 00") , $_ })}
Set-Alias -Name news -Value getNews
clear
$funks = @('timehere', 'ustime', 'goahk', 'goneovim', 'gocode', 'goText', 'gopro', 'gowt', 'goInit', 'showCode', 'github', 'addToast', 'addtask', 'searchGithub', 'google', 'youtube', 'getfile', 'getDir', 'addgitignore', 'newGit', 'pushahk', 'pushInit', 'pushWT', 'pushPro', 'pushit', 'goodNight', 'goToInventar', 'goToStart', 'neov', 'nd', 'goStartup', 'goroot', 'goIdeavim', 'goBookShop', 'getMNews', 'checknet', 'goToVim', 'getNews')
