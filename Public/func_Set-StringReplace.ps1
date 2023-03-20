<#
 .Synopsis
  Takes a string and replaces all subsctrings that match a regex with another string.

 .Description
  Takes a string, either via the pipeline or via the -String parameter, finds all matches to the regex that's provided via the -Match parameter,
  and replaces those matches with the string provided via the -Replacement parameter.

  Supports regex substitutions and capturing groups.

 .Parameter Match
 A case-sensitive regex matching pattern that's used to identify the substrings that will be replaced.

 .Parameter Replacement
 A case-sensitive regex substitution pattern that's used to replace the matched substrings with.

 .Parameter String
 Can only be present when there is no pipeline input. If present, this is the string that's used as the source
 for the replacements. All substrings of this string that match the pattern will be replaced.

 .Example
  # Replace comma's with periods using named parameters.
  Set-StringReplace -Match ',' -Replacement '.' -String '$12,30 $6,49 $109,99 $64,99'

 .Example
  # Replace periods with exclamation marks using positional parameters and an alias.
  nrep '\.' '!' -String 'Hello, world...'

 .Example
  # Replace periods with question marks on the piped input using positional parameters, an alias.
  'Hello, world.' | nrep '\.' '?'
#>
function Set-StringReplace {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param(
        [Parameter(Position = 0, Mandatory, ParameterSetName = 'Default')]
        [Parameter(Position = 0, Mandatory, ParameterSetName = 'Pipeline')]
        [String]
        $match

        ,[Parameter(Position = 1, Mandatory, ParameterSetName = 'Default')]
        [Parameter(Position = 1, Mandatory, ParameterSetName = 'Pipeline')]
        [String]
        $replacement

        ,[Parameter(ValueFromPipeline, ParameterSetName = 'Default')]
        [String]
        $string
    )

    process {
        $originalString = ''

        If ($PSCmdlet.ParameterSetName -eq 'Default') {
            $originalString = $string
        } ElseIf ($PSCmdlet.ParameterSetName -eq 'Pipeline') {
            $originalString = $_
        } Else {
            throw "No string was specified. Either pass a String object through the pipeline, or set the -String parameter."
        }

        return $originalString -creplace $match,$replacement
    }
}

New-Alias -Name nstringreplace -Value Set-StringReplace
New-Alias -Name nreplace -Value Set-StringReplace
New-Alias -Name nrep -Value Set-StringReplace
