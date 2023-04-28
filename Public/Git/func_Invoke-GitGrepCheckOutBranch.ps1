<#
 .Synopsis
  Wraps command: ggcob

 .Description
  Wraps the following command: ngllb | ngrep
#>
function Invoke-GitGrepCheckOutBranch {
  (Out-GitGrepListLocalBranches $args[0])[0] | ForEach-Object { git checkout $_ }
}

New-Alias -Name nggcob -Value Invoke-GitGrepCheckOutBranch
New-Alias -Name ggcob -Value Invoke-GitGrepCheckOutBranch
New-Alias -Name gcob -Value Invoke-GitGrepCheckOutBranch
