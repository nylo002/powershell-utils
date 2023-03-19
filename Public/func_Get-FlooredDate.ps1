enum DateTimeUnit {
    Millisecond
    Second
    Minute
    Hour
    Day
    Month
    Year
}

<#
 .Synopsis
  Floors a DateTime object and returns the result.

 .Description
  Floors a DateTime object to the nearest of a given unit.
  For example, "2023-03-19 14:39:01" can be floored to the nearest minute, the nearest hour,
  the nearest day, etc.

 .Parameter Date
 The DateTime object to be floored.

 .Parameter Unit
 The unit to floor to. (Millisecond, Second, Minute, Hour, Day, Month, Year)
 Defaults to Day.

 .Example
  # Floor to the nearest month.
  Get-FlooredDate "2023-19-03 14:01:55" -Unit Month
#>
function Get-FlooredDate {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)]
        [datetime]
        $date

        ,[Parameter(Position = 1, Mandatory = $false)]
        [DateTimeUnit]
        $unit = [DateTimeUnit]::Day
    )

    switch ($unit) {
        Millisecond { return (Get-Date $date -Millisecond $date.Millisecond) } #Looks weird, but is necessary to ensure we floor away any sub-millisecond portions (e.g. nanosec).
        Second { return (Get-Date $date -Millisecond 0) }
        Minute { return (Get-Date $date -Second 0 -Millisecond 0) }
        Hour { return (Get-Date $date -Minute 0 -Second 0 -Millisecond 0) }
        Day { return (Get-Date $date -Hour 0 -Minute 0 -Second 0 -Millisecond 0) }
        Month { return (Get-Date $date -Day 1 -Hour 0 -Minute 0 -Second 0 -Millisecond 0) }
        Year { return (Get-Date $date -Month 1 -Day 1 -Hour 0 -Minute 0 -Second 0 -Millisecond 0) }
    }
}

New-Alias -Name nfloordate -Value Get-FlooredDate