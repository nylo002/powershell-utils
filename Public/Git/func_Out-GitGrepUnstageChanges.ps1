<#
 .Synopsis
  Wraps command: ggus

 .Description
  Wraps the following command: ggus
#>
function Out-GitGrepUnstageChanges {
  $gitRoot = $(git rev-parse --show-toplevel)
  Out-GitGrepListStagedChanges $args[0] | ForEach-Object {
    git reset -q -- $(Join-Path $gitRoot $_)
  }
  git status
}

New-Alias -Name nggus -Value Out-GitGrepUnstageChanges
New-Alias -Name ggus -Value Out-GitGrepUnstageChanges
New-Alias -Name gus -Value Out-GitGrepUnstageChanges
