. (Join-Path $PSScriptRoot ..\..\Private\ModuleUtils.ps1)

<#
 .Synopsis
  Creates a .ps1 file in the current directory containing a function that wraps a command.

 .Description
  Creates (or overwrites) a .ps1 file with a function that wraps a command.
  This is useful to use as an alias for frequently uses commands, which can be as long and complex as desired.

  The file will be placed in the current directory.

 .Parameter Name
  The name of the wrapper. The file will be named 'func_<Name>.ps1'

 .Parameter Module
  Must be a path to a module manifest (.psd1 file). If present, adds this wrapper to the list of exported functions and aliases of the module.
  Only updates the manifest and not the module file (.psm1).

 .Parameter Aliases
  The aliases for this wrapper. It's recommended to name the wrapper something long and descriptive
  and to use these aliases as short-hands.

 .Parameter ShortDescription
  The text that will be used by Get-Help as the synopsis of this function.

 .Parameter LongDescription
  The text that will be used by Get-Help as the description of this function.

 .Parameter Overwrite (o)
  Unless this switch is active, the cmdlet will not overwrite any existing file.

 .Example
  #Create a new wrapper named 'func_Get-AllFilesAndDirectories.ps1' and give it an alias 'la'.
  New-CommandWrapper Get-AllFilesAndDirectories 'Get-ChildItem -Force' -Aliases la

 .Example
  #Create a new wrapper and add it and it's aliases to a module named 'ps-module'.
  newwrap Get-FilesSortedBySize 'Get-ChildItem | Sort-Object -Descending -Property Length' -Module ps-module.psd1
#>
function New-CommandWrapper {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory)]
        [String] $name

        ,[Parameter(Position = 1, Mandatory)]
        [String] $command

        ,[Parameter(Position = 2)]
        [ValidateScript({ Test-Path -Path $_ -PathType Leaf },
            ErrorMessage = "File does not exist.")]
        [String] $module

        ,[Parameter()]
        [String[]] $aliases

        ,[Parameter()]
        [String] $shortDescription = "Wraps command: $(If ($command.Length -gt 32) { ($command[0..31] | Join-String) + "..." } Else { $command })"

        ,[Parameter()]
        [String] $longDescription = "Wraps the following command: $command"

        ,[Alias('o')]
        [Parameter()]
        [switch] $overwrite
    )

    $filePath = ".\func_$name.ps1"

    # Check whether the path already exists. If it exists as a file, check if we can overwrite.
    If (Test-Path -Path $filePath -PathType Container) {
        throw "Can't create file at $filePath, since it already exists as a directory. Try specifying a custom path with the -Path parameter."
    } Elseif ((Test-Path -Path $filePath -PathType Leaf) -and (-not $overwrite)) {
        throw "Can't create file at $filePath since it already exists. Try specifying the -Overwrite switch."
    }

    $aliasesToInclude = @()

    # Is the module param present?
    If ($module) {
        $functionResults = Test-FunctionInModule -functionName $name -manifestPath $module

        $aliasResults = Test-AliasesInModule -aliasNames $aliases -manifestPath $module

        $aliasResults.AliasesAlsoInModule | ForEach-Object {
            Write-Warning "Alias $_ was already present in manifest. Won't add it again to avoid duplicates."
        }

        $aliasesToInclude = $aliasResults.AliasesNotInModule

        # If the function is not present in the manifest, add it to the manifest.
        If ($functionResults.PresentInModule) {
            Write-Warning "Function is already present in the module. Won't add again, and won't add aliases."
        } Else {
            $functionsToExport = $functionResults.FunctionsInModule + $name
            $aliasesToExport = $aliasResults.AliasesInModule + $aliasResults.AliasesNotInModule

            Update-ModuleManifest -Path $module -FunctionsToExport $functionsToExport -AliasesToExport $aliasesToExport
            Write-Output "Module has been updated with the new function and it's aliases."
        }
    }

    # Output the template to the file, and expand any variables as though the string were a double quoted string.
    If ($aliasesToInclude) {
        $aliasesContents = $aliasesToInclude | ForEach-Object {
            "New-Alias -Name $_ -Value $name"
        }
        $aliasesContents = $aliasesContents -join "`r`n"
    } Else {
        $aliasesContents = @()
    }

    $fileContents = $ExecutionContext.InvokeCommand.ExpandString(@'
<#
 .Synopsis
  $shortDescription

 .Description
  $longDescription
#>
function $name {
    `$argsString = `$args | Join-String -Separator " "
    `$commandWithArgs = "$command `$argsString"
    Invoke-Command -ScriptBlock ([ScriptBlock]::Create(`$commandWithArgs))
}

$aliasesContents
'@)

    Out-File -FilePath $filePath -InputObject $fileContents
}

New-Alias -Name nwrap -Value New-CommandWrapper