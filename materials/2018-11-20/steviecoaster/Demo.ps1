#region Backup to AD
$KeyProtectorId = (Get-BitLockerVolume).KeyProtector.KeyProtectorId[0]
Backup-BitLockerKeyProtector -MountPoint C: -KeyProtectorId $KeyProtectorId
#endregion

#region Quickly Get a recovery key, even remotely
Function Get-BitlockerKeyProtectorId {

    <#
    .SYNOPSIS
    Retrieve Key Protector Info from computers

    .PARAMETER Computer
    Remote computer to query

    .PARAMETER KeyType
    Which Protector do you want information for?

    .EXAMPLE
    Get-BitlockerKeyProtectorId

    .EXAMPLE
    Get-BitlockerKeyProtectorId -KeyType TPM
    #>

    [cmdletBinding()]
    Param(
        [Parameter(Position = 0)]
        [string[]]
        $Computername,

        [Parameter(Position = 1 )]
        [ValidateSet('TPM', 'RecoveryPassword', 'Both')]
        [String]
        $KeyType
    )

    $Scriptblock = {

        Switch ($KeyType) {

            "RecoveryPassword" {$Protectors = (Get-BitLockerVolume).KeyProtector[0]}
            "TPM" {$Protectors = (Get-BitLockerVolume).KeyProtector[1]}
            "Both" {$Protectors = (Get-BitLockerVolume).KeyProtector}
            default { $Protectors = (Get-BitLockerVolume).KeyProtector}

        }

        $Object = [pscustomobject]@{

            KeyProtectorId   = $Protectors.KeyProtectorId
            KeyProtectorType = $Protectors.KeyProtectorType
            RecoveryPassword = $Protectors.RecoveryPassword
            Status           = $Protectors.VolumeStatus
            ProtectionStatus = $Protectors.ProtectionStatus

        }

        $Object
    }

    If ($Computername) {

        Invoke-Command -ComputerName $Computername -ScriptBlock $Scriptblock
    }

    Else {

        $Scriptblock.InvokeReturnAsIs()

    }

}
#endregion

#region Toast....this is me we are talking about
Function Pop-BitlockerEncryptionToast {
    [cmdletBinding()]
    Param(
        [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]
        $Computername
    )
    Process {
        Start-Job -ScriptBlock {




            If ($using:Computername) {
                $Session = New-PSSession -ComputerName $using:Computername
            }




            Function Get-Percentage {
                If ($using:Computername) {
                    $script:EncryptionPercentage = Invoke-Command -Session $Session -ScriptBlock { (Get-BitLockerVolume).EncryptionPercentage }
                }
                Else {
                    $script:EncryptionPercentage = (Get-BitLockerVolume).EncryptionPercentage
                }

            }

            #Get the value currently, before dropping into the while loop.
            Get-Percentage

            #Sleep for 5 minutes between checks, as encryption does take some time to complete
            While ($EncryptionPercentage -lt 100) {

                Start-Sleep -Seconds (60 * 5)
                Get-Percentage
            }

            $Header = New-BTHeader -Id 1 -Title "Encryption Complete!"
            New-BurntToastNotification -Text "Encryption on $($using:Computername) has completed!" -Header $Header -Silent



            Get-PSSession | Remove-PSSession

        }
    }
}
#endregion