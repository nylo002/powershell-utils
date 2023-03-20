<#
 .Synopsis
  Wraps command: nglsc | ngrep

 .Description
  Wraps the following command: nglsc | ngrep
#>
function Out-GitGrepListStagedChanges {
    $argsString = $args | Join-String -Separator " "
    $commandWithArgs = "nglsc | ngrep $argsString"
    Invoke-Command -ScriptBlock ([ScriptBlock]::Create($commandWithArgs))
}

New-Alias -Name ngglsc -Value Out-GitGrepListStagedChanges
New-Alias -Name gglsc -Value Out-GitGrepListStagedChanges
