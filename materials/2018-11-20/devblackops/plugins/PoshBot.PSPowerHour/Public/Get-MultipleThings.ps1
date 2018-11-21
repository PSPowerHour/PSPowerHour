function Get-MultipleThings {
    <#
    .SYNOPSIS
        Accepts multple values for a parameter
    .EXAMPLE
        !get-multplethings --thing1 foo, bar --thing2 'asdf', 'qwerty'
    #>
    [cmdletbinding()]
    param(
        [string[]]$Thing1,
        [string[]]$Thing2
    )

    Write-Output "Thing1: $($Thing1 | Format-List | Out-String)"
    Write-Output "Thing2: $($Thing2 | Format-List | Out-String)"
}