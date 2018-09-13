
Install-Module OperationValidation -Scope CurrentUser
Import-Module OperationValidation

$oldPath = $env:PSModulePath
$env:PSModulePath += ";$($pwd.path)"

Get-OperationValidation

$tests = Get-OperationValidation -Name MyApp.OVF
$tests

# Run tests by tag
$criticalTests  = Get-OperationValidation -Name MyApp.OVF -Tag Critical
$criticalTests

$importantTests = Get-OperationValidation -Name MyApp.OVF -Tag Important
$importantTests

$critResults = $criticalTests | Invoke-OperationValidation -IncludePesterOutput
$critResults

$importantResults = $importantTests | Invoke-OperationValidation -IncludePesterOutput
$importantResults

# Override test parameters
$memoryTests = Get-OperationValidation -Name MyApp.OVF -Tag Memory
$memResults = $memoryTests | Invoke-OperationValidation -IncludePesterOutput
$memResults = $memoryTests | Invoke-OperationValidation -IncludePesterOutput -Overrides @{FreeRamMbytesThreshold = 10000}

$appTests = Get-OperationValidation -Name MyApp.OVF -Tag App
$appTests
$appResults = $appTests | Invoke-OperationValidation -IncludePesterOutput
$appResults = $appTests | Invoke-OperationValidation -IncludePesterOutput -Overrides @{Url = 'https://microsoft.com'}

$appResults

$env:PSModulePath = $oldPath
