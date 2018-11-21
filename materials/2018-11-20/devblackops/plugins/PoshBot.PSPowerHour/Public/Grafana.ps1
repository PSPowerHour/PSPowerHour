function Grafana {
    <#
    .SYNOPSIS
        Returns a grafana graph
    .EXAMPLE
        grafana cpu server01
    #>
    [PoshBot.BotCommand(
        CommandName = 'grafana',
        TriggerType = 'regex',
        Regex = '^grafana\s(cpu|disk)\s(.*)'
    )]
    [cmdletbinding()]
    param(
        [parameter(ValueFromRemainingArguments = $true)]
        [object[]]$Arguments
    )

    write-output $Arguments[0]
    write-output $Arguments[1]
    write-output $Arguments[2]
}