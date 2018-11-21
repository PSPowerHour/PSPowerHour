function Start-LongRunningCommand {
    <#
    .SYNOPSIS
        Start a long running command
    .EXAMPLE
        !start-longrunningcommand [--seconds 20]
    #>
    [cmdletbinding()]
    param(
        [int]$Seconds = 20
    )

    Start-Sleep -Seconds $Seconds
    Write-Output "[Start-LongRunningCommand] finished after [$Seconds] seconds"
}