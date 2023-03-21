<#
 .Synopsis
  Wraps command: git commit -m

 .Description
  Wraps the following command: git commit -m
#>
function Invoke-GitCommit {
    $argsString = $args | Join-String -Separator " "
    $escapedArgsString = $argsString -replace "'", "''"
    $commandWithArgs = "git commit -m '$escapedArgsString'"
    Invoke-Command -ScriptBlock ([ScriptBlock]::Create($commandWithArgs))
}

New-Alias -Name ngcom -Value Invoke-GitCommit
New-Alias -Name gcom -Value Invoke-GitCommit
