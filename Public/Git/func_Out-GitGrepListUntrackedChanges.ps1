<#
 .Synopsis
  Wraps command: ngluc | ngrep

 .Description
  Wraps the following command: ngluc | ngrep
#>
function Out-GitGrepListUntrackedChanges {
    $argsString = $args | Join-String -Separator " "
    $commandWithArgs = "ngluc | ngrep $argsString"
    Invoke-Command -ScriptBlock ([ScriptBlock]::Create($commandWithArgs))
}

New-Alias -Name nggluc -Value Out-GitGrepListUntrackedChanges
New-Alias -Name ggluc -Value Out-GitGrepListUntrackedChanges
