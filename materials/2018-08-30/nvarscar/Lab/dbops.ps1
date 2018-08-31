### Cleanup
Function cleanup { 
    $null = Remove-DbaDatabase -SqlInstance localhost -Database dbops -Confirm:$false
    Invoke-DbaSqlQuery -SqlInstance localhost -Query "CREATE DATABASE dbops"
    Remove-Item C:\Lab\dbops\* -Recurse
    Remove-Item C:\Lab\packages\* -Recurse
    Copy-Item 'C:\Lab\builds\1. DB\*' C:\Lab\dbops -Recurse
}
cleanup

# Settings
##List default settings
Get-DBODefaultSetting


##Set default settings
Set-DBODefaultSetting -Name database -Value dbops




# Simple deployments
## Execute sample script
Set-Location C:\
Invoke-DBODeployment -ScriptPath C:\Lab\dbops -SqlInstance localhost -Database dbops
Invoke-DbaSqlQuery -SqlInstance localhost -Database dbops -Query "SELECT schema_name(schema_id) as [Schema], name FROM sys.tables" | Out-GridView
Invoke-DbaSqlQuery -SqlInstance localhost -Database dbops -Query "SELECT * FROM SchemaVersion" | Out-GridView


## Add procedures to the list of deployment scripts
cleanup
Set-Location C:\Lab\dbops
Invoke-DBODeployment -ScriptPath .\*
Copy-Item 'C:\Lab\builds\7. Stored Procedures' C:\Lab\dbops -Recurse -PassThru
Invoke-DBODeployment -ScriptPath .\*




# Packages and build system
## Building a package
cleanup
Set-Location C:\Lab\packages
New-DBOPackage -Name dbopsPackage -ScriptPath C:\Lab\dbops\* -Build 1.0

## Checking package object
Invoke-Item C:\Lab\packages\dbopsPackage.zip
$package = Get-DBOPackage C:\Lab\packages\dbopsPackage.zip
$package | Select-Object *
$package | Get- Member | Where-Object MemberType -eq 'Method'


## Adding builds to the package
$newPackage = Add-DBOBuild -Path $package -ScriptPath 'C:\Lab\builds\7. Stored Procedures' -Build 2.0
$newPackage.Builds
$newPackage.GetBuild('2.0').Scripts
$newPackage.GetBuild('1.0').Scripts[4].GetContent()


## Deploying package to a custom versioning table
$newPackage | Install-DBOPackage -DeploymentMethod SingleTransaction -SchemaVersionTable dbo.DeploymentLog


# Configuration
## Package configuration
(Get-DBOPackage C:\Lab\packages\dbopsPackage.zip).Configuration
Update-DBOConfig .\dbopsPackage.zip -Configuration @{DeploymentMethod='SingleTransaction'}
(Get-DBOPackage C:\Lab\packages\dbopsPackage.zip).Configuration.DeploymentMethod

## Custom configurations
$hT = @{ DeploymentMethod = 'TransactionPerFile' }
Install-DBOPackage .\dbopsPackage.zip -Configuration $hT

## Configuration files
$config = (Get-DBOPackage C:\Lab\packages\dbopsPackage.zip).Configuration
$config.SchemaVersionTable
$config.SchemaVersionTable = 'dbo.DeploymentLog'
$config.SaveToFile('.\dbops.json') 
notepad .\dbops.json
Install-DBOPackage .\dbopsPackage.zip -ConfigurationFile .\dbops.json




# CI/CD stuff
cleanup
Get-ChildItem .

## Create a new package using continuous integration features and automatic versioning
Invoke-DBOPackageCI -Name .\dbopsPackage.zip -ScriptPath C:\Lab\dbops\* -Version 0.5

## Augment the package with a new build using same source folder
Copy-Item 'C:\Lab\builds\7. Stored Procedures' C:\Lab\dbops -Recurse -PassThru
Invoke-DBOPackageCI -Name .\dbopsPackage.zip -ScriptPath C:\Lab\dbops\* -Version 0.5
Get-DBOPackage .\dbopsPackage.zip | Select-Object -ExpandProperty Builds

### Essentially, the same as using 
Add-DBOBuild  -Name .\dbopsPackage.zip -ScriptPath C:\Lab\dbops\* -Build 0.5.3 -Type New

## Store package in a repository
$dir = New-Item C:\Lab\packages\Repo -ItemType Directory
Publish-DBOPackageArtifact -Path .\dbopsPackage.zip -Repository $dir

## Deploy the package from a repository
Get-DBOPackageArtifact -Name dbopsPackage -Repository $dir | Install-DBOPackage



# SMO forever
cleanup
## create package
$package = New-DBOPackage -Name dbopsPackage -ScriptPath C:\Lab\dbops\* -Build 1.0
## get the database object
$database = Get-DbaDatabase -SqlInstance localhost -Database dbops
$database





# Here comes
$database.Deploy($package)
