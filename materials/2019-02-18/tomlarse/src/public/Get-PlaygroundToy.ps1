function Get-PlaygroundToy {
    <#
    .EXTERNALHELP PlaygroundTools-help.xml
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,Position=0)]
        [string]$Identity
    )
    
    begin {
    }
    
    process {
        dir | Out-Null
    }
    
    end {
    }
}