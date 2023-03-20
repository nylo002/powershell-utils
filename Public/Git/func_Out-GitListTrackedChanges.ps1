<#
 .Synopsis
  Wraps command: git diff --name-only

 .Description
  Wraps the following command: git diff --name-only
#>
function Out-GitListTrackedChanges {
    git diff --name-only
}

New-Alias -Name ngltc -Value Out-GitListTrackedChanges
