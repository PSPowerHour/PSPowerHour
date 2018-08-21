# get available modules and check to see if dbatools is installed
Write-Host "Checking if dbatools is installed" -ForegroundColor 'Yellow'
$module = Get-Module -Name 'dbatools' -ListAvailable

# if dbatools is not installed, install it from the gallery
if (-not $module) {
    Write-Host "Installing dbatools module" -ForegroundColor 'Yellow'
    try {
        $null = Install-Module -Name 'dbatools' -Scope 'CurrentUser'
    }
    catch {
        $_
        exit
    }
}
else {
    Write-Host 'dbatools is already installed' -ForegroundColor 'Green'
}

# import dbatools module
Write-Host "Importing dbatools module" -ForegroundColor 'Yellow'
Import-Module -Name 'dbatools' -Force

Write-Host "PowerShell setup complete" -ForegroundColor 'Green'