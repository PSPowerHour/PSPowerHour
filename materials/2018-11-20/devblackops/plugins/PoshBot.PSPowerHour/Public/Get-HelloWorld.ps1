
function Get-HelloWorld {
    <#
    .SYNOPSIS
    Say hello to the world
    .EXAMPLE
    !get-helloworld -name brandon
    #>
    [cmdletbinding()]
    param(
        [parameter(Mandatory)]
        [string]$Name
    )

    "Hello $Name"
}
