function Add-PlaygroundToy {
    <#
    .EXTERNALHELP PlaygroundTools-help.xml
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true,Position=0,ValueFromPipeline=$true )]
        [PlaygroundToy]$Toy,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
        [String]$Identity
    )
    
    begin {
    }
    
    process {
        dir | Out-Null
    }
    
    end {
    }
}