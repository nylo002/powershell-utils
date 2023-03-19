. (Join-Path $PSScriptRoot ..\Private\ModuleUtils.ps1)

<#
 .Synopsis
  Creates a .ps1 file containing a default function in the current directory.

 .Description
  Creates (or overwrites) a .ps1 file with a function containing some default contents; basically a template.
  This is helpful when creating functions for a module, since this takes away some of the boilerplate.

  This cmdlet will place the file in the current directory.

 .Parameter Name
  The name of the function. The file will be named 'func_<Name>.ps1'

 .Parameter Module
  Must be a path to a module manifest (.psd1 file). If present, adds this function to the list of exported functions and aliases sof the module.
  Only updates the manifest and not the module file (.psm1).

 .Parameter Aliases
  The aliases for this function.

 .Parameter Overwrite (o)
  Unless this switch is active, the cmdlet will not overwrite any existing file.

 .Example
  #Create a new file named 'func_Default-Function.ps1', or overwrite it if it already exists.
  New-FunctionFile 'Default-Function' -Overwrite
#>
function New-FunctionFile {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory)]
        [String] $name

        ,[Parameter(Position = 1)]
        [ValidateScript({ Test-Path -Path $_ -PathType Leaf },
            ErrorMessage = "File does not exist.")]
        [String] $module

        ,[Parameter()]
        [String[]] $aliases

        ,[Alias('o')]
        [Parameter()]
        [switch] $overwrite
    )

    $filePath = ".\func_$name.ps1"

    # Check whether the path already exists. If it exists as a file, check if we can overwrite.
    If (Test-Path -Path $filePath -PathType Container) {
        Write-Error "Can't create file at $filePath, since it already exists as a directory. Try specifying a custom path with the -Path parameter."
        exit 1
    } Elseif ((Test-Path -Path $filePath -PathType Leaf) -and (-not $overwrite)) {
        Write-Error "Can't create file at $filePath since it already exists. Try specifying the -Overwrite switch."
        exit 1
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
  Short format description of the function.

 .Description
  Long format description of the function.

 #.Parameter DefaultParam
 Description of the DefaultParam parameter

 #.Example
 #  # Show default output of this command.
 #  $name
#>
function $name {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = `$true)][String] `$defaultParam
    )

    Write-Output 'Default output of $name.'
}

$aliasesContents
'@)

    Out-File -FilePath $filePath -InputObject $fileContents
}

New-Alias -Name nfunc -Value New-FunctionFile