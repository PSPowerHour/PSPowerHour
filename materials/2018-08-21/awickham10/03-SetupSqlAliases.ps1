Write-Host 'Setting up SQL aliases' -ForegroundColor 'Yellow'

foreach ($container in $Containers.GetEnumerator()) {
    $alias = dbatools\Get-DbaClientAlias | Where-Object { $_.AliasName -eq $container.Key }
    if (-not $alias) {
        Write-Host "Creating an alias $($container.Key) pointing to localhost,$($container.Value.Port)" -ForegroundColor 'Yellow'
        $null = dbatools\New-DbaClientAlias `
            -ComputerName 'localhost' `
            -ServerName "localhost,$($container.Value.Port)" `
            -Alias $container.Key
    }
    else {
        Write-Host "Alias for $($container.Key) already exists" -ForegroundColor 'Green'
    }
}

Write-Host 'SQL Alias setup complete' -ForegroundColor 'Green'