<#
 .Synopsis
  Wraps command: git ls-files --modified --others

 .Description
  Wraps the following command: git ls-files --modified --others
#>
function Out-GitListUnstagedChanges {
    git ls-files $(git rev-parse --show-toplevel) --modified --others --exclude-standard
}

New-Alias -Name nglnc -Value Out-GitListUnstagedChanges
