<#
 .Synopsis
  Wraps command: git diff --name-only --cached

 .Description
  Wraps the following command: git diff --name-only --cached
#>
function Out-GitListStagedChanges {
  git diff --name-only --cached --full-index
}

New-Alias -Name nglsc -Value Out-GitListStagedChanges
