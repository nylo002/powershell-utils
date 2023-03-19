Get-ChildItem "$(Split-Path $script:MyInvocation.MyCommand.Path)\Public\*" -Filter 'func_*.ps1' -Recurse | ForEach-Object {
    . $_.FullName
}

Export-ModuleMember -Function * -Alias *