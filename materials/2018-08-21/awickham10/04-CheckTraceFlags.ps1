Describe -Name "Trace Flags" -Fixture {
    foreach ($server in $servers) {
        Context -Name "server $server" -Fixture {
            $flags = dbatools\Get-DbaTraceFlag `
                -SqlInstance $server `
                -SqlCredential $credential

            $testCases = @()
            foreach ($flag in $TraceFlags) {
                $testCases += @{
                    'TraceFlag' = $flag
                }
            }

            It -Name "should have <TraceFlag> enabled" -TestCases $testCases -Test {
                param ($TraceFlag)

                $flags.TraceFlag | Should -Contain $TraceFlag
            }
        }
    }
}
