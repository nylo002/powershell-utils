<#
 .Synopsis
  Lists all (hidden) files and subdirectories in a directory.

 .Description
  Lists all (hidden) files and subdirectories in a directory. By default, this is the current directory,
  but this can be changed via the -Path parameter.

 .Parameter Path
  Must be a path that exists. Performs the cmd on this path instead of the current directory.
#>
function Get-AllChildItems {
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0)]
        [String] $path
    )

    Get-ChildItem -Force $path
}

New-Alias -Name la -Value Get-AllChildItems
