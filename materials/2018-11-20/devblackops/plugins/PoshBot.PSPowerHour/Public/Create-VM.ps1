function Create-VM {
    <#
    .SYNOPSIS
        Creates a new VM
    .EXAMPLE
        !create-vm -name server01 -vcpu 2 -ram 1024
    #>
    [PoshBot.BotCommand(
        CommandName = 'createvm'
    )]
    [cmdletbinding()]
    param(
        [string]$Name = (New-Guid).ToString().split('-')[4],

        [ValidateSet('Linux', 'Windows')]
        [string]$Type = 'Windows',

        [ValidateRange(1, 16)]
        [int]$vCPU = 1,

        [ValidateRange(1, 128)]
        [int]$RAM = 1
    )

    if ($environment -eq 'dev') {
        $location = 'westus'
    } else {

    }

    $r = [pscustomobject]@{
        Name      = $Name
        vCPU      = $vCPU
        RAM       = $RAM
        Type      = $Type
        IPAddress = '10.11.12.13'
    }

    $msg = ($r | Format-List -Property * | Out-String)
    New-PoshBotCardResponse -Title "VM [$Name] Created" -Text $msg
}
