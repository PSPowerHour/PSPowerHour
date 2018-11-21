function Set-MyStuff {
    <#
    .SYNOPSIS
    Sets some stateful storage
    .EXAMPLE
    !setmystuff -name foo -value bar
    #>
    [PoshBot.BotCommand(
        CommandName = 'setmystuff'
    )]
    [cmdletbinding()]
    param(
        [parameter(mandatory)]
        [string]$Name,

        [parameter(mandatory)]
        [string]$Value,

        [switch]$Global
    )

    $stateScope = if ($Global) { 'Global'} else { 'Module'}
    Set-PoshBotStatefulData -Name $Name -Value $Value -Scope $stateScope
    New-PoshBotTextResponse -Text "[$Value] saved to [$stateScope`:$Name]"
}