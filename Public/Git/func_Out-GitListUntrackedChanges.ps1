<#
 .Synopsis
  Wraps command: git ls-files --others

 .Description
  Wraps the following command: git ls-files --others
#>
function Out-GitListUntrackedChanges {
    git ls-files $(git rev-parse --show-toplevel) --others --exclude-standard
}

New-Alias -Name ngluc -Value Out-GitListUntrackedChanges
