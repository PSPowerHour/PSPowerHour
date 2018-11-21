function Get-RandomNumber {
    <#
    .SYNOPSIS
        Get a random number
    .EXAMPLE
        !get-randomnumber -min 1 -max 42
    #>
    [PoshBot.BotCommand(
        Aliases = ('rand', 'rnd')
    )]
    [cmdletbinding()]
    param(
        [int]$Min = 1,
        [int]$Max = 100
    )

    Get-Random -Minimum $min -Maximum $Max
}
