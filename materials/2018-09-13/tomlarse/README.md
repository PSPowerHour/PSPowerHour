* **Name**: Tom-Inge Larsen
* **Title**: Relearning the troubleshooting basics in Powershell
* **Abstract**: ping, nslookup, arp and traceroute all have PS equivalents. Time to start using them!
* **Twitter**: @ti83
* **SlackID**: @Tom-Inge
* **Blog**: https://blog.codesalot.com

# PS Equivalent commands

What | Traditional | Powershell | alias | comments
-----|-------------|------------|-------|----------
Find IP addresses|`ipconfig`|`Get-NetIpConfiguration`|`gip`|
Find DNS servers|`ipconfig /all`|`Get-NetIPConfiguration`|`gip`|
DNS lookups|`nslookup`|`Resolve-DnsName`||
Clear local DNS cache|`ipconfig /flushdns`|`Clear-DnsClientCache`||
Check network connectivity|`ping`|`Test-NetConnection`|`tnc`|Test-Connection from PS core 6.1
Check TCP port connectivity|`telnet`|`Test-NetConnection`|`tnc`|Test-Connection from PS core 6.1
Find network route|`tracert`|`Test-NetConnection -traceroute`|`tnc`|Test-Connection from PS core 6.1
Simple DNS lookup|`ping`|`Test-NetConnection`|`tnc`|Test-Connection from PS core 6.1
Find current listening and established network connections|`netstat -ano`|`Get-NetTcpConnection`||Will not list UDP connections as netstat does
Find active layer 2 neighbors|`arp -a`|`Get-NetNeighbor`||