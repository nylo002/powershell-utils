<#
 .Synopsis
  Wraps command: nglnc | ngrep

 .Description
  Wraps the following command: nglnc | ngrep
#>
function Out-GitGrepListUnstagedChanges {
    $argsString = $args | Join-String -Separator " "
    $commandWithArgs = "nglnc | ngrep $argsString"
    Invoke-Command -ScriptBlock ([ScriptBlock]::Create($commandWithArgs))
}

New-Alias -Name ngglnc -Value Out-GitGrepListUnstagedChanges
New-Alias -Name gglnc -Value Out-GitGrepListUnstagedChanges
