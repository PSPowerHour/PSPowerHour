$SaPassword = 'Pa55w0rd'
$Containers = @{
    'sql1' = @{
        Image = 'microsoft/mssql-server-windows-developer:latest'
        Port = 49149
    }
    'sql2' = @{
        Image = 'microsoft/mssql-server-windows-developer:latest'
        Port = 49150
    }
    'sql3' = @{
        Image = 'microsoft/mssql-server-windows-developer:latest'
        Port = 49151
    }
}
$TraceFlags = @(1117, 1118, 2371, 3226)

$secureString = ConvertTo-SecureString $SaPassword -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ('sa', $secureString)

$servers = @()
foreach ($container in $Containers.GetEnumerator()) {
    $servers += $container.Key
}

$null = Read-Host "Press Enter to Start Setup"
. '.\01-SetupContainers.ps1'

$null = Read-Host -Prompt "Press Enter to Continue to Step #2 - Setup PowerShell"
. '.\02-SetupPowerShell.ps1'

$null = Read-Host -Prompt "Press Enter to Continue to Step #3 - Setup SQL Aliases"
. '.\03-SetupSqlAliases.ps1'

$null = Read-Host -Prompt "Press Enter to Continue to Step #4 - Check Trace Flags"
. '.\04-CheckTraceFlags.ps1'

$null = Read-Host -Prompt "Press Enter to Continue to Step #5 - Set Trace Flags"
. '.\05-SetTraceFlags.ps1'

$null = Read-Host -Prompt "Press Enter to Continue to Step #6 - Check Trace Flags"
. '.\06-CheckTraceFlags.ps1'