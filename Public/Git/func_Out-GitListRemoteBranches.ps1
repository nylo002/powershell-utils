<#
 .Synopsis
  Wraps command: git branch --remote

 .Description
  Wraps the following command: git branch --remote
#>
function Out-GitListRemoteBranches {
  git for-each-ref --format='%(refname:short)' 'refs/remotes'
}

New-Alias -Name nglrb -Value Out-GitListRemoteBranches
