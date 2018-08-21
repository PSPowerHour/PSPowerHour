# login to docker for pulling image
Write-Host "Login to Docker" -ForegroundColor 'Yellow'
docker login

# setup our containers we specified in the Execute script
Write-Host "Setting up containers" -ForegroundColor 'Green'
foreach ($container in $Containers.GetEnumerator()) {
    $name = $container.Key

    # see if the container already exists using docker ps -a
    $exists = docker ps -a | Select-String $name

    # it's running if it's "Up"
    $running = $exists | Select-String 'Up'

    if ($exists -and $running) {
        Write-Host "Container $name is already running" -ForegroundColor 'Green'
        continue
    }
    elseif ($exists -and -not $running) {
        Write-Host "Starting container $name on port $($container.Value.Port)" -ForegroundColor 'Yellow'
        $command = "docker container start $name"
    }
    else {
        Write-Host "Creating container $name on port $($container.Value.Port)" -ForegroundColor 'Yellow'
        $command = "docker run -d -p $($container.Value.Port):1433 -e sa_password=$SaPassword -e ACCEPT_EULA=Y --name=$name $($container.Value.Image)"
    }

    # execute command we need to
    Write-Host "Executing $command" -ForegroundColor 'Yellow'
    $null = Invoke-Command -ScriptBlock ([ScriptBlock]::Create($command))
}

Write-Host "Container setup complete" -ForegroundColor 'Green'