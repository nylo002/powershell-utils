<#
 .Synopsis
  Short format description of the function.

 .Description
  Long format description of the function.

 #.Example
 #  # Show default output of this command.
 #  Invoke-GitRemoveMergedBranches
#>
function Invoke-GitRemoveMergedBranches {
    [CmdletBinding()]
    param()

    $currentBranch = git branch --show-current

    # 1. Get all branches merged into the current branch
    # 2. Select all that aren't the current branch
    # 3. Delete selected branches
    git branch --merged | Select-String -CaseSensitive -NotMatch -Pattern $currentBranch | ForEach-Object { git branch -D $_.ToString().Trim() }

    # Prune remote branches
    git fetch --prune

    # Output branches
    Write-Host "Remaining branches:"
    git branch | ForEach-Object { Write-Host $_ }
}

New-Alias -Name ngrmb -Value Invoke-GitRemoveMergedBranches
New-Alias -Name grmb -Value Invoke-GitRemoveMergedBranches
