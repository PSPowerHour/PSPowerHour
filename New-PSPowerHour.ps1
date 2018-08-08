<#
    .SYNOPSIS
        Generate the markdown table of the presenters for the PSPowerHour
    .NOTES
        This utilizes PowerShellForGitHub module by the PowerShell team
        For best results and the way written you will need a token from GitHub (no permissions needed to be assigned)
#>
[cmdletbinding()]
param(
    [string]$GitHubToken
)

function ConvertTo-Markdown {
    <#
    .SYNOPSIS
        Converts a PowerShell object to a Markdown table.
        https://mac-blog.org.ua/powershell-convertto-markdown/
    .EXAMPLE
        $data | ConvertTo-Markdown
    .EXAMPLE
        ConvertTo-Markdown($data)
    #>
    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true
        )]
        [PSObject[]]$collection
    )

    Begin {
        $items = @()
        $columns = @{}
    }

    Process {
        ForEach ($item in $collection) {
            $items += $item

            $item.PSObject.Properties | % {
                if (-not $columns.ContainsKey($_.Name) -or $columns[$_.Name] -lt $_.Value.ToString().Length) {
                    $columns[$_.Name] = $_.Value.ToString().Length
                }
            }
        }
    }

    End {
        ForEach ($key in $($columns.Keys)) {
            $columns[$key] = [Math]::Max($columns[$key], $key.Length)
        }

        $header = @()
        ForEach ($key in $columns.Keys) {
            $header += ('{0,-' + $columns[$key] + '}') -f $key
        }
        $header -join ' | '

        $separator = @()
        ForEach ($key in $columns.Keys) {
            $separator += '-' * $columns[$key]
        }
        $separator -join ' | '

        ForEach ($item in $items) {
            $values = @()
            ForEach ($key in $columns.Keys) {
                $values += ('{0,-' + $columns[$key] + '}') -f $item.($key)
            }
            $values -join ' | '
        }
    }
}

Import-Module PowerShellForGitHub
$data = Get-GitHubIssueForRepository -repositoryUrl 'https://github.com/pspowerhour/pspowerhour' -gitHubAccessToken $GitHubToken |
    Where-Object {$_.labels.name -eq 'proposal'} | Select-Object Number, Title, user | sort-object Number | select-object -first 10
[int]$sequence = 1
$data | ForEach-Object {
    [PSCustomObject][ordered]@{
        Order = "{0:00}" -f $sequence
        IssueNumber = "#$($_.Number)"
        By          = "@$($_.user.login)"
        Title       = $_.Title
        StandBy     = if ($sequence -gt 5) {"Yes"} else {"No"}
    }
    $sequence++
} | Select-Object Order, IssueNumber, By, Title, StandBy ConvertTo-Markdown

#ToDo
# Order of columns is being messed with in the custom function to convert the table to markdown. Have not reviewed fully to get that straighted out