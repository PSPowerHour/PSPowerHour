# Introduction

## The ipconfigs

### `ipconfig`

`Get-NetIpConfiguration`
`gip`

### `ipconfig /all`

`Get-NetIpConfiguration`

`Get-NetAdapter`

`Get-NetIPAddress`

### `ipconfig /flushdns`

`Clear-DnsClientCache`

## ICMP

### ping

`Test-NetConnection`

`Test-NetConnection vg.no`

`tnc vg.no`

PS 6.1

`Test-Connection vg.no`

### traceroute

`Test-NetConnection vg.no -TraceRoute`

`Test-Connection vg.no -TraceRoute`

## DNS

### nslookup

`Resolve-DnsName vg.no`

`Resolve-DnsName vg.no -Server 8.8.8.8`

`Resolve-DnsName -Type SRV -Name _sipfederationtls._tcp.microsoft.com`

## network connections

### telnet

`Test-NetConnection vg.no http`

`Test-NetConnection sip.microsoft.com -Port 5061`

PS 6.1

`Test-Connection sip.microsoft.com -TCPPort 5061`

### `arp -a`

`Get-NetNeighbor`

### `netstat -ano`

`Get-NetTCPConnection`

## Why

Because powershell output.
* Have seen people write string parsers to sort output

`netstat -ano | findstr "139"`
Then maybe
`netstat -ano | findstr "139 listening"`

`Get-NetTCPConnection -State Listen -LocalPort 139`

github issue
https://github.com/PowerShell/PowerShell/issues/6076

