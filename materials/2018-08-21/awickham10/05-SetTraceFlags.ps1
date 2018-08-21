foreach ($server in $servers) {
    Write-Host "Connecting to $server" -ForegroundColor 'Yellow'
    $smo = dbatools\Connect-DbaInstance -SqlInstance $server -Credential $credential

    Write-Host "Setting trace flags on $server to $($TraceFlags -join ',')" -ForegroundColor 'Yellow'
    $null = dbatools\Enable-DbaTraceFlag `
        -SqlInstance $smo `
        -SqlCredential $credential `
        -TraceFlag $TraceFlags
}