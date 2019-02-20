function Remove-PlaygroundToy {
    <#
    .EXTERNALHELP PlaygroundTools-help.xml
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,Position=0)]
        [string]$Identity,
        [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [PlaygroundToy]$Toy
    )
    
    begin {
    }
    
    process {
        dir | Out-Null
    }
    
    end {
    }
}