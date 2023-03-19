Function Test-FunctionInModule {
    param(
        [String] $functionName
        ,[String] $manifestPath
    )

    $moduleManifest = Import-PowerShellDataFile -Path $manifestPath -SkipLimitCheck

    # Get the existing list of functions if it exists.
    If ($moduleManifest.ContainsKey('FunctionsToExport')) {
        $functionsToExport = $moduleManifest.FunctionsToExport -split ','
    } Else {
        $functionsToExport = @()
    }

    $functionIsInModule = $false

    # Check if the function wasn't already added to the manifest.
    foreach ($function in $functionsToExport) {
        If ($function -eq $name) {
            $functionIsInModule = $true
            break
        }
    }

    return @{
        FunctionsInModule = $functionsToExport
        PresentInModule = $functionIsInModule
    }
}

#Returns which of the supplied alias names is present in the supplied manifest.
Function Test-AliasesInModule {
    param(
        [String[]] $aliasNames
        ,[String] $manifestPath
    )

    $moduleManifest = Import-PowerShellDataFile -Path $manifestPath -SkipLimitCheck

    # Get the existing list of aliases if it exists.
    If ($moduleManifest.ContainsKey('AliasesToExport')) {
        $aliasesToExport = $moduleManifest.AliasesToExport -split ','
    } Else {
        $aliasesToExport = @()
    }

    $aliasesAlsoInModule = @()
    $aliasesNotInModule = @()

    # Only keep aliases that don't already exist in the manifest.
    foreach ($alias in $aliasNames) {
        $inModule = $false

        foreach ($aliasToExport in $aliasesToExport) {
            if($alias -eq $aliasToExport) {
                $inModule = $true
                break
            }
        }

        If ($inModule) {
            $aliasesAlsoInModule += $alias
        } Else {
            $aliasesNotInModule += $alias
        }
    }

    return @{
        AliasesAlsoInModule = $aliasesAlsoInModule
        AliasesNotInModule = $aliasesNotInModule
        AliasesInModule = $aliasesToExport
    }
}