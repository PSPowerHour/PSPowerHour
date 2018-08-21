# See empty default
$PSDefaultParameterValues

#region  Example 1: Turn off confirmation prompts and enable verbose for all commands (useful in automation/scheduled jobs)

# Sample command before
Import-Module dbatools -Force

# Add to existing $PSDefaultParameterValues
$PSDefaultParameterValues['*:Confirm'] = $false
$PSDefaultParameterValues['*:Verbose'] = $true
$PSDefaultParameterValues

# Sample command after
Import-Module dbatools -Force

#endregion

#region Example 2:  Specify a saved credential for all dbatools commands

# Sample command before
Get-DbaDatabase -SqlInstance localhost

# Use a saved credential for all dbatools commands, overwrite existing PSDefaultParameterValues
$PSDefaultParameterValues = @{ '*-Dba*:SqlCredential' = { Import-CliXml -Path "$home\Documents\sqlcred.xml" } }
$PSDefaultParameterValues

# Sample command after
Get-DbaDatabase -SqlInstance localhost

#endregion

#region Example 3:  Dynamic Default Parameter Value

# Sample command before 
Get-ChildItem -Directory | Select -Last 1 | Format-Table

# Add HideTableHeaders to Format-Table *if* you're running in ISE
$PSDefaultParameterValues += @{
    "Format-Table:HideTableHeaders" = {
        if ($host.Name -eq "Windows PowerShell ISE Host") { $true }
    }
}

# Sample command after
Get-ChildItem -Directory | Select -Last 1 | Format-Table

#endregion

#region  Disabling $PSDefaultParameterValues

# Sample command before 
Get-DbaDatabase -SqlInstance localhost

# Disable $PSDefaultParameterValues
$PSDefaultParameterValues["Disabled"] = $true
$PSDefaultParameterValues

# Sample command after
Get-DbaDatabase -SqlInstance localhost

 # Remove Disabled
$PSDefaultParameterValues.Remove('Disabled')
$PSDefaultParameterValues

# Sample command again
Get-DbaDatabase -SqlInstance localhost

#endregion

<# 

Questions?

*   dbatools.io/defaults
*   twitter.com/cl
*   #powerhour in powershell.slack.com
*   github.com/PSPowerHour/PSPowerHour/issues/2

#> 