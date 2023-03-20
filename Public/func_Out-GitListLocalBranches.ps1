<#
 .Synopsis
  Wraps command: git branch

 .Description
  Wraps the following command: git branch
#>
function Out-GitListLocalBranches {
    git branch
}

New-Alias -Name ngllb -Value Out-GitListLocalBranches
