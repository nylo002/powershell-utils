<#
 .Synopsis
  Wraps command: Out-GitGrepListUnstagedChanges $args[0] | % { git add $_ }

 .Description
  Wraps the following command: Out-GitGrepListUnstagedChanges $args[0] | % { git add $_ }
#>
function Invoke-GitGrepAddUnstagedChanges {
    Out-GitGrepListUnstagedChanges $args[0] | ForEach-Object { git add $_ }
    git status
}

New-Alias -Name nggadd -Value Invoke-GitGrepAddUnstagedChanges
New-Alias -Name ggadd -Value Invoke-GitGrepAddUnstagedChanges
New-Alias -Name gadd -Value Invoke-GitGrepAddUnstagedChanges
