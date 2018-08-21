## 1) Import-Module
Import-Module dbatools

## 2) Find dbatools functions for compression
Get-Command -Module dbatools -Name *compression*

## 3) Get more information about Get-DbaDbCompression
Get-Help -Name Get-DbaDbCompression -ShowWindow

## 4) What should we compress - Tiger team SQL Script
$results = Test-DbaDbCompression `
-SqlInstance localhost\sql2016 `
-Database AdventureWorks2016

## 5) Let's look at the results for SalesOrderDetail
$results |
Where-Object TableName -eq 'SalesOrderDetail' |
Select-Object Schema, TableName, IndexName, IndexType, SizeCurrent, SizeRequested, CompressionTypeRecommendation

## 6) Let's apply the suggested compression to the database
Set-DbaDbCompression `
-SqlInstance localhost\sql2016 `
-Database AdventureWorks2016 `
-InputObject $results

## 7) Check current compression
Get-DbaDbCompression -SqlInstance localhost\sql2016 -Database AdventureWorks2016 |
Out-GridView

## 8) Bonus - compress whole database with Row compression
Set-DbaDbCompression `
-SqlInstance localhost\sql2016 `
-Database AdventureWorks2016 `
-CompressionType Row ## Page, Recommended, None
