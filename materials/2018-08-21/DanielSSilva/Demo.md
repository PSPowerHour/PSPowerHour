sudo pwsh

# Import Modules 
Import-Module Microsoft.PowerShell.IoT
Import-Module /home/pi/Documents/Presentation/PowerShell-IoT---IS31FL3730-Driver/ScrollpHat.psd1
Import-Module /home/pi/Documents/Presentation/Posh-SenseHat/Sensors/HTS221_Humidity_Temperature/HTS221_Humidity_Temperature.psd1
Import-Module /home/pi/Documents/Presentation/rpi-ws281x-csharp/publish/ws281xPowerShell.dll
Import-Module /home/pi/Documents/Presentation/Posh-SenseHat/LedMatrix/bin/Debug/netcoreapp2.0/linux-arm/publish/LedMatrix.dll

Get-Command -Module Microsoft.PowerShell.IoT

Write-PhatString "POWER HOUR" -Forever

# Launch Job that Gets current temperature and shows on scrollPhat
$job = Start-Job -ScriptBlock {Import-Module /home/pi/Documents/Presentation/PowerShell-IoT---IS31FL3730-Driver/ScrollpHat.psd1
Import-Module /home/pi/Documents/Presentation/Posh-SenseHat/Sensors/HTS221_Humidity_Temperature/HTS221_Humidity_Temperature.psd1
$temperature = Get-CurrentTemperature
Write-PhatString "Current temperature = $($temperature)C" -Forever}


Set-TemperatureColor $(Get-CurrentTemperature)

Set-ImageFromFile /home/pi/Documents/Presentation/space_invader.png

# Links for repos:

* PowerShell IoT - https://github.com/PowerShell/PowerShell-IoT
* SenseHat - https://github.com/DanielSSilva/Posh-SenseHat
* NeoPixels (Leds) - https://github.com/rpi-ws281x/rpi-ws281x-csharp
* ScrollPhat - https://github.com/DanielSSilva/PowerShell-IoT---IS31FL3730-Driver


