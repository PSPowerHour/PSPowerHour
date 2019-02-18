function New-PlaygroundDumpTruck {
    <#
    .EXTERNALHELP PlaygroundTools-help.xml
    #>
    [CmdletBinding()]
    [OutputType([PlaygroundToy])]
    param (
        [Parameter(Mandatory=$true,Position=0,ValueFromPipelineByPropertyName=$true)]
        [string]$Name,
        [Parameter(Mandatory=$true,Position=1,ValueFromPipelineByPropertyName=$true)]
        [string]$Height,
        [Parameter(Mandatory=$true,Position=2,ValueFromPipelineByPropertyName=$true)]
        [string]$Length,
        [Parameter(Mandatory=$false,Position=3,ValueFromPipelineByPropertyName=$true)]
        [string]$Color
    )
    
    begin {
    }
    
    process {
    }
    
    end {
    }
}