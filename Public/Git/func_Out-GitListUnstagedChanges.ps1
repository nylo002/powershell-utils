<#
 .Synopsis
  Wraps command: git ls-files --modified --others

 .Description
  Wraps the following command: git ls-files --modified --others
#>
function Out-GitListUnstagedChanges {
    $argsString = $args | Join-String -Separator " "
    $commandWithArgs = "git ls-files --modified --others $argsString"
    Invoke-Command -ScriptBlock ([ScriptBlock]::Create($commandWithArgs))
}

New-Alias -Name nglnc -Value Out-GitListUnstagedChanges
