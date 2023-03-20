<#
 .Synopsis
  Short format description of the function.

 .Description
  Long format description of the function.

 #.Parameter DefaultParam
 Description of the DefaultParam parameter

 #.Example
 #  # Show default output of this command.
 #  Select-StringWithDefaults
#>
function Select-StringWithDefaults {
    [CmdletBinding()]
    param(
        [Parameter(ValueFromPipeline)]
        [String[]]
        $inputObjects,

        [Parameter(Position = 0, Mandatory)]
        [String]
        $regex,
        
        [Parameter()]
        [Alias('s')]
        [switch]
        $caseSensitive,

        [Parameter()]
        [Alias('i')]
        [switch]
        $invert,

        [Parameter()]
        [Alias('c')]
        [switch]
        $returnCount,

        [Parameter()]
        [Alias('a')]
        [switch]
        $allMatches
    )

    begin {
        $count = 0
    }
    process {
        $command = '$_ | Select-String $regex'
        If ($caseSensitive) { $command += ' -CaseSensitive' }
        If ($allMatches) { $command += ' -AllMatches' }
        If ($invert) { $command += ' -NotMatch' }

        $matchInfo = Invoke-Command -ScriptBlock ([ScriptBlock]::Create($command))
        $count += $matchInfo.Matches.Length

        If (-not $returnCount) {
            return $matchInfo
        }
    }
    end {
        If ($returnCount) { return $count }
    }
}

New-Alias -Name ngrep -Value Select-StringWithDefaults
