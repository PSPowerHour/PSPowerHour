# Load the PowerShell Module and PSLogging Class
#region 

if (Get-Module -Name PSLogging){
    Remove-Module -Name PSLogging -Force
}
Set-Location -Path C:\_Github
Import-Module C:\_GitHub\PSLogging\PSLogging\PSLogging.psm1 -Force

#endregion
################################################

# Get Exported Commands
#region

(Get-Module -Name PSLogging).ExportedCommands

#endregion
################################################

# Open our PSLOgging Class
#region

PSedit C:\_GitHub\PSLogging\PSLogging\Class\PSLogging.psm1

#endregion
################################################

# Let's create a new [EventViewer] instance
#region

$LogName = 'PSLogging Test'
$LogSource = 'PSPowerHour'
$EventViewerLogging = [EventViewer]::new($LogName,$LogSource)

#endregion
################################################

# [EventViewer] Write to the Event Log
#region

$EventViewerLogging.Info("Informational log from $LogSource under $LogName")
$EventViewerLogging.Debug("Debug log from $LogSource under $LogName")
$EventViewerLogging.Success("Success log from $LogSource under $LogName")
$EventViewerLogging.Warning("Warning log from $LogSource under $LogName")
$EventViewerLogging.Error("Error log from $LogSource under $LogName")

try{
    Get-Example
}catch{
    $EventViewerLogging.Error("Error log from $LogSource under $LogName",$Error[0])
}

#endregion
################################################

# Let's create a new [EventViewer] instance
#region

$logFile = 'C:\PSPowerHour\log.log'

$LogFileLogging = [LogFile]::new($logFile)

#endregion
################################################

# [LogFile] Write to a Log File
#region

$LogFileLogging.Info("Informational event to $logFile")
$LogFileLogging.Debug("Debug event to $logFile")
$LogFileLogging.Success("Success event to $logFile")
$LogFileLogging.Warning("Warning event to $logFile")
$LogFileLogging.Error("Error event to $logFile")

try{
    Get-Example
}catch{
    $LogFileLogging.Error("Error event to $logFile",$Error[0])
}

PSEdit $logFile

#endregion
################################################

# Let's create a new [EventViewer] instance
#region

$WriteHostLogging = [WriteHost]::new()

#endregion
################################################

# [LogFile] Write to a Log File
#region

$WriteHostLogging.Info("Informational event using WriteHost Class")
$WriteHostLogging.Debug("Debug event using WriteHost Class")
$WriteHostLogging.Success("Success event using WriteHost Class")
$WriteHostLogging.Warning("Warning event using WriteHost Class")
$WriteHostLogging.Error("Error event to using WriteHost Class")

try{
    Get-Example
}catch{
    $WriteHostLogging.Error("Error event using WriteHost Class",$Error[0])
}

#endregion
################################################

# Now, let's Change colors of our log messages
#region

$WriteHostLogging.setInfoColor("Red")
$WriteHostLogging.setDebugColor("Cyan")
$WriteHostLogging.setSuccessColor("Gray")
$WriteHostLogging.setWarningColor("White")
$WriteHostLogging.setErrorColor("Green")


$WriteHostLogging.Info("Informational event using WriteHost Class")
$WriteHostLogging.Debug("Debug event using WriteHost Class")
$WriteHostLogging.Success("Success event using WriteHost Class")
$WriteHostLogging.Warning("Warning event using WriteHost Class")
$WriteHostLogging.Error("Error event to using WriteHost Class")

try{
    Get-Example
}catch{
    $WriteHostLogging.Error("Error event using WriteHost Class",$Error[0])
}

#endregion
################################################

# Let's combine some logging
#region

try{
    Get-PSPowerHour
}
catch{
    $errValue = $Error[0]
    $errMessage = 'Example of logging to multiple sources'

    $EventViewerLogging.Error($errMessage,$errValue)
    $LogFileLogging.Error($errMessage,$errValue)
    $WriteHostLogging.Error($errMessage,$errValue)
}

#endregion
################################################

# Open our private functions
#region

PSedit C:\_GitHub\PSLogging\PSLogging\Public\New-EventViewerClass.ps1, 
       C:\_GitHub\PSLogging\PSLogging\Public\New-LogFileClass.ps1, 
       C:\_GitHub\PSLogging\PSLogging\Public\New-WriteHostClass.ps1

#endregion
################################################
