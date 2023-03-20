<#
 .Synopsis
  Wraps command: ngltc | ngrep

 .Description
  Wraps the following command: ngltc | ngrep
#>
function Out-GitGrepListTrackedChanges {
    $argsString = $args | Join-String -Separator " "
    $commandWithArgs = "ngltc | ngrep $argsString"
    Invoke-Command -ScriptBlock ([ScriptBlock]::Create($commandWithArgs))
}

New-Alias -Name nggltc -Value Out-GitGrepListTrackedChanges
New-Alias -Name ggltc -Value Out-GitGrepListTrackedChanges
