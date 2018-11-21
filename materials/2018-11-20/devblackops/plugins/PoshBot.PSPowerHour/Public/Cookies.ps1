function Cookies {
    <#
    .SYNOPSIS
    Respond to cookies
    #>
    [PoshBot.BotCommand(
        Command = $false,
        CommandName = 'cookies',
        TriggerType = 'regex',
        Regex = 'cookies'
    )]
    [cmdletbinding()]
    param(
        [parameter(ValueFromRemainingArguments)]
        $Dummy
    )

    Write-Output 'Did someone mention cookies? I love cookies! Nom Nom Nom!'
}
