#region Reminder
Function New-ToastReminder {

    [cmdletBinding()]
    Param(
        [Parameter(Mandatory, Position = 0)]
        [string]
        $ReminderTitle,

        [Parameter(Mandatory, Position = 1)]
        [string]
        $ReminderText,

        [Parameter(Position = 2)]
        [int]
        $Seconds,

        [Parameter(Position = 3)]
        [Int]
        $Minutes,

        [Parameter(Position = 4)]
        [Int]
        $Hours
    )

    Begin {}

    Process {

        Start-Job -ArgumentList $ReminderTitle,$ReminderText,$Seconds,$Minutes,$Hours -ScriptBlock {
            #Countdown reminders
            $watch = New-Object System.Diagnostics.Stopwatch
            $watch.Start()

            Switch ($true) {

                $args[4] { $seconds = $hours * 60 * 60}
                $args[3] {$seconds = $minutes * 60}
                $args[2] { >$null }
            }
            While ($watch.Elapsed.TotalSeconds -lt $args[2]) {

                Out-Null
            }
            $watch.Stop()
            $Head = New-BTHeader -ID 1 -Title $args[0]
            Toast -Text $args[1] -Header $Head -AppLogo $null
        } > $null
    }

    End {}

}
#endregion

#region Engine Event
Import-Module BurntToast

Register-EngineEvent -SourceIdentifier Powershell.Exiting -Action {

    $header = New-BTHeader -Id 1 -Title "Automation Done"
    New-BurntToastNotification -Text "Hey there! That script you wrote is finished." -Silent -Header $header

}
#endregion

#region Button fun
$button = New-BTButton -Id 1 -Content 'Go' -Arguments 'https://play.grafana.org/d/000000052/advanced-layout?panelId=2&fullscreen&orgId=1'
#$action = New-BTAction -Buttons $button                                                                           
$header = New-BTHeader -Id 1 -Title 'Service Degradation Alert'                                                   
New-BurntToastNotification -Button $button -Text "There's an issue. Click 'Go' to View" -Header $header
#endregion

#region Toner checks
Function Get-XeroxTonerStatus {
    <#
    .SYNOPSIS
    Scans printers on a network via SNMP for toner level percentages

    .DESCRIPTION
    Pulls the Capacity value, and current value of the toner cartridges, and does math to read back a percentage.
    If the percentage is less than or equal to your threshold value, a toast notification is raised on target computer(s).

    .PARAMETER AlertThresholdPercentage
    The % a toner needs to be at before a toast is raised. Low number recommended (ie, 5)

    .PARAMETER SnmpString
    The GET snmp string utilized on your network

    .PARAMETER Printers
    A CSV file containg the following headers:
    IP Address,Name,FriendlyName,Type

    .PARAMETER Computers
    Array of computers to send a toast notification too.

    .EXAMPLE
    Get-XeroxTonerStatus -Printers "F:\Automation\ToastData.csv" -SnmpString 'Fancy-String' -AlertThresholdPercentage 50

    .EXAMPLE
    Get-XeroxTonerStatus -Printers "F:\Automation\ToastData.csv" -Computers pc1,pc2,pc3 -SnmpString 'Fancy-String' -AlertThresholdPercentage 50

    #>

    Param(
        [cmdletBinding()]
        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullorEmpty()]
        [string]$Printers,
        [Parameter(Mandatory = $False, Position = 1)]
        [string[]]$Computers,
        [Parameter(Mandatory, Position = 2)]
        [string]$SnmpString,
        [Parameter(Mandatory, Position = 3)]
        [int]$AlertThresholdPercentage
    )
   
    #Pre-reqs
    #Import-Module BurntToast
    If (!(Test-Path C:\usr\bin\snmpget.exe)) {
       
        Write-Error "Net-SNMP required. Install: http://www.net-snmp.org/download.html"
       
        Break
       
    }

    #region: OID Values. Tested on Xerox Altalink C8035,C8055, Versalink C405,C400,B400. Your may need to adjust these per your models.
    $blackFullOID = '.1.3.6.1.2.1.43.11.1.1.8.1.1'
    $blackCurrentOID = '.1.3.6.1.2.1.43.11.1.1.9.1.1'
    $yellowFullOID = '.1.3.6.1.2.1.43.11.1.1.8.1.2'
    $yellowCurrentOID = '.1.3.6.1.2.1.43.11.1.1.9.1.2'
    $magentaFullOID = '.1.3.6.1.2.1.43.11.1.1.8.1.3'
    $magentaCurrentOID = '.1.3.6.1.2.1.43.11.1.1.9.1.3'
    $cyanFullOID = '.1.3.6.1.2.1.43.11.1.1.8.1.4'
    $cyanCurrentOID = '.1.3.6.1.2.1.43.11.1.1.9.1.4'
    #end region

    $Data = Import-Csv $Printers
    Foreach ($printer in $Data) {
       
        $ip = $printer.'IP Address'
        
        #region check connectivity and gather snmp data
        If (!(Test-Connection $ip -Quiet -Count 1)) {

            #New-BurntToastNotification -Text "Printer: $($printer.FriendlyName) appears OFFLINE!" -AppLogo "F:\Automation\Images\K.png"
             
        }

        Else {
            Write-Verbose -Message "Gathering data on: $($printer.FriendlyName)"
            If ($printer.Type -notmatch 'BW') {
            
                $blackFullReading = C:\usr\bin\snmpget -v '2c' -c $SnmpString -O v $ip $blackFullOID
                $blackCurrentReading = C:\usr\bin\snmpget -v '2c' -c $SnmpString -O v $ip $blackCurrentOID

                $yellowFullReading = C:\usr\bin\snmpget -v '2c' -c $SnmpString -O v $ip $yellowFullOID
                $yellowCurrentReading = C:\usr\bin\snmpget -v '2c' -c $SnmpString -O v $ip $yellowCurrentOID

                $magentaFullReading = C:\usr\bin\snmpget -v '2c' -c $SnmpString -O v $ip $magentaFullOID
                $magentaCurrentReading = C:\usr\bin\snmpget -v '2c' -c $SnmpString -O v $ip $magentaCurrentOID

                $cyanFullReading = C:\usr\bin\snmpget -v '2c' -c $SnmpString -O v $ip $cyanFullOID
                $cyanCurrentReading = C:\usr\bin\snmpget -v '2c' -c $SnmpString -O v $ip $cyanCurrentOID

            }

            Else {
            
                $blackFullReading = C:\usr\bin\snmpget -v '2c' -c $SnmpString -O v $ip $blackFullOID
                $blackCurrentReading = C:\usr\bin\snmpget -v '2c' -c $SnmpString -O v $ip $blackCurrentOID

            }
            #endregion
        
            #Region extract only digits from snmp string
            $blackFull = $blackFullReading.Split(':')[1].Trim()
            $blackCurrent = $blackCurrentReading.Split(':')[1].Trim()

            $yellowFull = $yellowFullReading.Split(':')[1].Trim()
            $yellowCurrent = $yellowCurrentReading.Split(':')[1].Trim()

            $magentaFull = $magentaFullReading.Split(':')[1].Trim()
            $magentaCurrent = $magentaCurrentReading.Split(':')[1].Trim()

            $cyanFull = $cyanFullReading.Split(':')[1].Trim()
            $cyanCurrent = $cyanCurrentReading.Split(':')[1].Trim()
            #Endregion

            #Region: Create objects of each % value
            [pscustomobject]$blackPercentRemaining = @{
                Value    = [math]::Round(([int]$blackCurrent / [int]$blackFull) * 100)
                Toner    = 'Black'
                Friendly = $printer | Select-Object -Expand FriendlyName

            }

            [pscustomobject]$yellowPercentRemaining = @{ 
                Value    = [math]::round(([int]$yellowCurrent / [int]$yellowFull) * 100)
                Toner    = 'Yellow'
                Friendly = $printer | Select-Object -Expand FriendlyName
            }
            
            [pscustomobject]$magentaPercentRemaining = @{
                Value    = [math]::Round(([int]$magentaCurrent / [int]$magentaFull) * 100)
                Toner    = 'Magenta'
                Friendly = $printer | Select-Object -Expand FriendlyName
            }
            
            [pscustomobject]$cyanPercentRemaining = @{
                Value    = [math]::Round(([int]$cyanCurrent / [int] $cyanFull) * 100)
                Toner    = 'Cyan'
                Friendly = $printer | Select-Object -Expand FriendlyName
            }
            #EndRegion
            
            #Region check values and raise alerts
            $readings = @($blackPercentRemaining, $yellowPercentRemaining, $magentaPercentRemaining, $cyanPercentRemaining)
            $lowArray = @()

            Foreach ($r in $readings) {
            
                If ($r.Value -le $alertThresholdPercentage) {
                    
                    $lowArray += $r
                }
                
            }#value foreach

            Foreach ($l in $lowArray) {
                
                If (!($Computers)) {
                
                    Out-Null
					
                }
                
                Else {
                
                    Foreach ($Computer in $Computers) {
                        
                        Invoke-Command -Computername $Computer -Scriptblock { Toast -Text $args[0], $args[1] } -Args ("Toner Alert for $($l.Friendly)", "$($l.Toner) Toner is at $($l.Value)%! Replace soon!")

                    }#toast computers foreach

                }#logic else
    
            }#toast foreach
            #endregion
        }
    }#printer foreach
 
}#function
 
$XeroxParams = @{
    Printers = "F:\Automation\PowerHour.csv"
    SnmpString = "PowerHour"
    AlertThresholdPercentage = 5
    Computers = 'localhost'
}
Get-XeroxTonerStatus @XeroxParams
#endregion