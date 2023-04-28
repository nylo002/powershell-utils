<#
 .Synopsis
  Lists all git branches, whether local or remote.

 .Description
  Wraps the following command: git branch -a
#>
function Out-GitListAllBranches {
  git for-each-ref --format='%(refname:short)' 'refs'
}

New-Alias -Name nglab -Value Out-GitListAllBranches