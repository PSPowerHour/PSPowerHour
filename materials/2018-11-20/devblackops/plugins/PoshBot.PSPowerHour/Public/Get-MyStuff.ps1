function Get-MyStuff {
    <#
    .SYNOPSIS
    Get stuff for stateful storage
    .EXAMPLE
    !getmystuff -name foo
    #>
    [PoshBot.BotCommand(
        CommandName = 'getmystuff'
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
        New-PoshBotCardResponse -Type Warning -Text "Couldn't find your stuff" -DM
    } else {
        New-PoshBotTextResponse -Text ($storedStuff | Format-List -Property * | Out-String) -AsCode -DM
    }
}