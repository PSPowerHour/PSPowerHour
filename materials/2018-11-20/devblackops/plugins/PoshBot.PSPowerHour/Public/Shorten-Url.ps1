function Shorten-Url {
    [PoshBot.BotCommand(
        CommandName = 'shorten'
    )]
    [cmdletbinding()]
    param(
        [parameter(Mandatory)]
        $Url,

        [PoshBot.FromConfig('GoogleApiShortenerApiKey')]
        [parameter(Mandatory)]
        [string]$ApiKey
    )

    $body = @{
        longUrl = $Url
    } | ConvertTo-Json
    $irmParams = @{
        Uri         = "https://www.googleapis.com/urlshortener/v1/url?key=$ApiKey"
        Method      = 'Post'
        Body        = $body
        ContentType = 'application/json'
    }

    try {
        $goo = Invoke-RestMethod @irmParams
        Write-Output "Nice link. I made it better: $($goo.id)"
    } catch {
        Write-Error $_
    }
}