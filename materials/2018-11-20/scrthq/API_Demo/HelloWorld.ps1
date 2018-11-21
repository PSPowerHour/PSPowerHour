Write-Host (ConvertTo-Json -InputObject $LambdaInput -Compress -Depth 5)
Write-Verbose (ConvertTo-Json -InputObject $LambdaContext -Compress -Depth 5) -Verbose
$result = "Hello from PowerShell Core Lambda, $($LambdaInput.path.split('/')[-1])!"
@{
    statusCode = 200
    body = $result
    headers = @{
        'Content-Type' = 'text/plain'
    }
}
