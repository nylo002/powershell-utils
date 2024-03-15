<#
 .Synopsis
  Short format description of the function.

 .Description
  Long format description of the function.

 #.Parameter DefaultParam
 Description of the DefaultParam parameter

 #.Example
 #  # Show default output of this command.
 #  Invoke-GitRemoveMergedBranches
#>
function Invoke-GitRemoveMergedBranches {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $true)][String] $defaultParam
    )

    Write-Output 'Default output of Invoke-GitRemoveMergedBranches.'
}

New-Alias -Name ngrmb -Value Invoke-GitRemoveMergedBranches
New-Alias -Name grmb -Value Invoke-GitRemoveMergedBranches
