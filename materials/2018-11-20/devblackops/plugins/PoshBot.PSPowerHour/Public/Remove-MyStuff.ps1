function Remove-MyStuff {
    <#
    .SYNOPSIS
    Removes some stateful storage
    .EXAMPLE
    !removemystuff -name foo
    #>
    [PoshBot.BotCommand(
        CommandName = 'removemystuff'
    )]
    [cmdletbinding()]
    param(
        [parameter(mandatory)]
        [string]$Name,

        [switch]$Global
    )

    $stateScope = if ($Global) { 'Global'} else { 'Module'}
    $storedStuff = Get-PoshBotStatefulData -Name $Name -ValueOnly -Scope $stateScope

    if (-not $storedStuff) {
        New-PoshBotCardResponse -Type Warning -Text "Couldn't find your stuff"
    } else {
        Remove-PoshBotStatefulData -Name $Name -Scope $stateScope
        New-PoshBotTextResponse -Text "[$Name] removed"
    }
}