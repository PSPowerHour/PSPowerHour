@{
    RootModule        = './MyApp.OVF.psm1'
    ModuleVersion     = '0.1.0'
    GUID              = 'f36dac3e-983e-4c6c-8378-eaf757aed87e'
    Author            = 'Brandon Olin'
    CompanyName       = 'Community'
    Copyright         = '(c) Brandon Olin. All rights reserved.'
    Description       = 'Tests the operation of MyApp'
    RequiredModules   = @('Pester')
    FunctionsToExport = '*'
    CmdletsToExport   = '*'
    VariablesToExport = '*'
    AliasesToExport   = '*'
    PrivateData       = @{
        PSData = @{
            # Tags = @()
            # LicenseUri = ''
            # ProjectUri = ''
            # IconUri = ''
            # ReleaseNotes = ''
        }
    }
}

