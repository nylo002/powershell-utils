<#
 .Synopsis
  Wraps command: ngllb | ngrep

 .Description
  Wraps the following command: ngllb | ngrep
#>
function Out-GitGrepListLocalBranches {
    $argsString = $args | Join-String -Separator " "
    $commandWithArgs = "ngllb | ngrep $argsString"
    Invoke-Command -ScriptBlock ([ScriptBlock]::Create($commandWithArgs))
}

New-Alias -Name nggllb -Value Out-GitGrepListLocalBranches
New-Alias -Name ggllb -Value Out-GitGrepListLocalBranches
New-Alias -Name gllb -Value Out-GitGrepListLocalBranches
