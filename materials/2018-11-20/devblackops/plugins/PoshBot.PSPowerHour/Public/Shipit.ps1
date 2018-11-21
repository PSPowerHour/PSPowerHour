function Shipit {
    <#
    .SYNOPSIS
        Display a motivational squirrel
    .EXAMPLE
        !shipit
    #>
    [PoshBot.BotCommand(
        Command = $false,
        CommandName = 'shipit',
        TriggerType = 'regex',
        Regex = 'shipit'
    )]
    [cmdletbinding()]
    param(
        [parameter()]
        $Arguments
    )

    $squirrels = @(
        'http://28.media.tumblr.com/tumblr_lybw63nzPp1r5bvcto1_500.jpg'
        'http://i.imgur.com/DPVM1.png'
        'http://d2f8dzk2mhcqts.cloudfront.net/0772_PEW_Roundup/09_Squirrel.jpg'
        'http://www.cybersalt.org/images/funnypictures/s/supersquirrel.jpg'
        'http://i.imgur.com/tIQluOd.jpg'
        'http://i.imgur.com/PIQBHKA.jpg'
        'http://i.imgur.com/Qp8iF6l.jpg'
        'http://i.imgur.com/I7drYFb.jpg'
    )

    New-PoshBotCardResponse -ImageUrl ($squirrels | Get-Random)

    #Write-Output $squirrels | Get-Random
}