<#
 .Synopsis
  Wraps command: git branch --remote

 .Description
  Wraps the following command: git branch --remote
#>
function Out-GitListRemoteBranches {
    git branch --remote
}

New-Alias -Name nglrb -Value Out-GitListRemoteBranches
