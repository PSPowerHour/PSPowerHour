function Bad-Command {
    <#
    .SYNOPSIS
        Intentionally throws errors
    .EXAMPLE
        !bad-command
    #>
    [cmdletbinding()]
    param()

    Write-Error -Message "I'm error number one"
    Write-Error -Message "I'm error number two"
}