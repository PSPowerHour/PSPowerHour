$critical  = @('Eventlog', 'RpcSs', 'lanmanserver', 'LmHosts', 'Lanmanworkstation', 'MpsSvc')
$important = @('DHCP', 'DNSCache', 'PlugPlay' ,'WinRM')

describe 'OS - Critical Services' -Tag Critical {
    $critical.Foreach({
        it "Service [$_] is running" {
            (Get-Service $_).Status | Should -Be 'Running'
        }
    })
}

describe 'OS - Important Services' -Tag Important {
    $important.Foreach({
        it "Service [$_] is running" {
            (Get-Service $_).Status | Should -Be 'Running'
        }
    })
}