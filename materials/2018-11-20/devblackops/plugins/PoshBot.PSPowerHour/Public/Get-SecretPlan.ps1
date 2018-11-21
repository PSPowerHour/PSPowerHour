function Get-SecretPlan {
    <#
    .SYNOPSIS
    Get the secret plan for world domination
    .EXAMPLE
    !get-secretplan
    #>
    [PoshBot.BotCommand(
        Permissions = ('getsecrets')
    )]
    [cmdletbinding()]
    param()

    $tmpDir = [System.IO.Path]::GetTempPath()

    $plan = [pscustomobject]@{
        Title       = "Secret moon base option"
        Description = 'Plans for secret base on the dark side of the moon'
    }
    $csv = Join-Path -Path $tmpDir -ChildPath "$((New-Guid).ToString()).csv"
    $plan | Export-Csv -Path $csv -NoTypeInformation
    New-PoshBotFileUpload -Path $csv -Title 'MoonBasePlan.csv' -DM
}