<#
 .Synopsis
  Wraps command: ggus

 .Description
  Wraps the following command: ggus
#>
function Invoke-GitGrepUnstageChanges {
  $gitRoot = $(git rev-parse --show-toplevel)
  Out-GitGrepListStagedChanges $args[0] | ForEach-Object {
    git reset -q -- $(Join-Path $gitRoot $_)
  }
  git status
}

New-Alias -Name nggus -Value Invoke-GitGrepUnstageChanges
New-Alias -Name ggus -Value Invoke-GitGrepUnstageChanges
New-Alias -Name gus -Value Invoke-GitGrepUnstageChanges
