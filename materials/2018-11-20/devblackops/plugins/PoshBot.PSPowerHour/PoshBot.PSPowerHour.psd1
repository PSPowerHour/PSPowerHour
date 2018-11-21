@{
    RootModule        = 'PoshBot.PSPowerHour.psm1'
    ModuleVersion     = '0.1.0'
    GUID              = '6cf41bc4-ffae-4440-a3f4-5aa3183e87d1'
    Author            = 'Brandon Olin'
    CompanyName       = 'Community'
    Copyright         = '(c) 2018 Brandon Olin. All rights reserved.'
    Description       = 'Example PoshBot commands for PSPowerHour'
    PowerShellVersion = '5.0.0'
    RequiredModules   = @('PoshBot')
    FunctionsToExport = '*'
    CmdletsToExport   = '*'
    VariablesToExport = '*'
    AliasesToExport   = '*'
    PrivateData       = @{
        Permissions = @(
            'getsecrets'
        )
        PSData      = @{
            Tags = @('PoshBot', 'PSPowerHour')
            # LicenseUri = ''
            # ProjectUri = ''
            # IconUri = ''
            # ReleaseNotes = ''
        }
    }
}

