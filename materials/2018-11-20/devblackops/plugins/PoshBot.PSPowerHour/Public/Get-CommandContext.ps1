function Get-CommandContext {
    [cmdletbinding()]
    param()

    New-PoshBotTextResponse -Text ($global:PoshBotContext | ConvertTo-Json -Depth 10) -AsCode
}