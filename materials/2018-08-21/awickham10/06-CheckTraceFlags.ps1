Describe -Name "Trace Flags" -Fixture {
    foreach ($server in $servers) {
        Context -Name "Server $server" -Fixture {
            $flags = dbatools\Get-DbaTraceFlag `
                -SqlInstance $server `
                -SqlCredential $credential

            $testCases = @()
            foreach ($flag in $TraceFlags) {
                $testCases += @{
                    'TraceFlag' = $flag
                }
            }

            It "should have <TraceFlag> enabled" -TestCases $testCases {
                param ($TraceFlag)

                $flags.TraceFlag | Should -Contain $TraceFlag
            }
        }
    }
}
