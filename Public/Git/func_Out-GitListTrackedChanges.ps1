<#
 .Synopsis
  Wraps command: git diff --name-only

 .Description
  Wraps the following command: git diff --name-only
#>
function Out-GitListTrackedChanges {
  git ls-files $(git rev-parse --show-toplevel) --modified --exclude-standard
}

New-Alias -Name ngltc -Value Out-GitListTrackedChanges
