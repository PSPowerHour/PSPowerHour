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

if (-not (Get-Module PowerShellForGitHub)) {
    Write-Output "Please install PowerShellForGitHub module!"
}
if (-not (Get-Module PSMarkdown -ListAvailable)) {
    Write-Output "Please install PSMarkdown module!"
}

try {
    Import-Module PowerShellForGitHub, PSMarkdown
}
catch {
    Write-Warning "Issue loading modules"
    $_
}
$data = Get-GitHubIssueForRepository -repositoryUrl 'https://github.com/pspowerhour/pspowerhour' -gitHubAccessToken $GitHubToken |
    Where-Object {$_.labels.name -eq 'proposal'} | Select-Object Number, Title, user | sort-object Number | select-object -first 10
[int]$sequence = 1
$data | ForEach-Object {
    [PSCustomObject][ordered]@{
        Order       = "{0:00}" -f $sequence
        IssueNumber = "#$($_.Number)"
        By          = "@$($_.user.login)"
        Title       = $_.Title
        StandBy     = if ($sequence -gt 5) {"Yes"} else {"No"}
    }
    $sequence++
} | Select-Object Order, IssueNumber, By, Title, StandBy | ConvertTo-Markdown