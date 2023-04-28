<#
 .Synopsis
  Wraps command: git branch

 .Description
  Wraps the following command: git branch
#>
function Out-GitListLocalBranches {
  git for-each-ref --format='%(refname:short)' 'refs/heads'
}

New-Alias -Name ngllb -Value Out-GitListLocalBranches
