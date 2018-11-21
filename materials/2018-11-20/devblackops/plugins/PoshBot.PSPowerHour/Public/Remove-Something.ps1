function Remove-Something {
    <#
    .SYNOPSIS
        Test switch parameters
    .EXAMPLE
        !remove-something foo -force
    #>
    [cmdletbinding()]
    param(
        [parameter(Mandatory, position = 0)]
        [string[]]$Name,

        [switch]$Force
    )

    if (-not $Force) {
        $warnMsg = "Are you sure you want to remove [$($Name -join ',')]? Use the -Force if you do."
        New-PoshBotCardResponse -Type Warning -Text $warnMsg
    } else {
        $msg = @()
        foreach ($item in $Name) {
            $msg += "Removed [$item]"
        }
        New-PoshBotCardResponse -Type Normal -Text ($msg | Format-List | Out-String)
    }
}