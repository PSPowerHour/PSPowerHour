
function ChannelTopicChange {
    <#
    .SYNOPSIS
        Responds to channel topic change events
    #>
    [PoshBot.BotCommand(
        Command = $false,
        TriggerType = 'event',
        MessageType = 'Message',
        MessageSubType = 'ChannelTopicChanged'
    )]
    [cmdletbinding()]
    param(
        [parameter(ValueFromRemainingArguments)]
        $Dummy
    )

    Write-Output 'I kind of liked the old topic'
}