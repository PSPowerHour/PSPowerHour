<#
Andy Levy
SQL Server DBA
dbatools contributor
https://therestisjustcode.wordpress.com/
#>

<#
sqlps and sqlserver modules

Invoke-SQLCmd

select * from mytable

Inserting from a file:
Loop!

$MyData = import-csv Path\To\File
foreach ($row in $MyData) {
    $Query = "insert into mytable ('$($row[0])','$($row[1]))"
    invoke-sqlcmd $Query;
}

1) Convenient
2) Potential for poor performance
3) Unsafe!
#>

Clear-Host;
$ErrorActionPreference = "Continue";
$VerbosePreference = "SilentlyContinue";

import-module dbatools, sqlserver;
$SQLInstance = "YOURSERVER";
$DemoDatabase = "PowerHappyHour";
$ErrorActionPreference = "Continue";
$VerbosePreference = "Continue";

function Invoke-Naive {
    Write-Verbose $MyInvocation.MyCommand; 
    $Establishments = @(
        "Nick's Chophouse",
        "Eddie O'Briens",
        "Simply Crepes",
        "Rocky's Cafe");

    foreach ($Establishment in $Establishments) {
        $MyInsertQuery = "insert into [PowerHappyHour].dbo.[Establishments]([FunctionUsed],[Name]) values ('Invoke-SqlCmd','$Establishment');";
        Write-Verbose $MyInsertQuery;
        invoke-sqlcmd -server $SQLInstance -query $MyInsertQuery -database $DemoDatabase;
    }
}

function Invoke-WithInjection {
    Write-Verbose $MyInvocation.MyCommand; 
    $Establishments = @(
        "Nick's Chophouse",
        "Eddie O'Briens",
        "Simply Crepes",
        "Rocky');create table [pwned] ([Gotcha] int identity(1,1));--s");

    foreach ($Establishment in $Establishments) {
        $MyInsertQuery = "insert into [PowerHappyHour].dbo.[Establishments]([FunctionUsed],[Name]) values ('Invoke-SqlCmd','$Establishment');";
        Write-Verbose $MyInsertQuery;
        invoke-sqlcmd -server $SQLInstance -query $MyInsertQuery -Database $DemoDatabase;
    }
}


<#
$Command = New-Object System.Data.SQLClient.SQLCommand
$Command.Connection = $dbConnection
$Command.CommandText = "INSERT INTO [PowerHappyHour].dbo.[Establishments] (FunctionUsed,Name) VALUES ('Invoke-SqlCmd',@Establishment)";
$Command.Parameters.Add("@Establishment", $Establishment);
$Command.ExecuteNonQuery();
#>

function Invoke-Safely {
    Write-Verbose $MyInvocation.MyCommand; 
    $Establishments = @(
        "Nick's Chophouse",
        "Eddie O'Briens",
        "Simply Crepes",
        "Rocky');create table [reallyPwned] ([Gotcha] int identity(1,1));--s");

    $MyParameterizedQuery = "insert into [PowerHappyHour].dbo.[Establishments]([FunctionUsed],[Name]) values (@FunctionName,@EstablishmentName)";
    foreach ($Establishment in $Establishments) {
        $QueryParameters = @{
            "FunctionName"      = "Invoke-DbaSqlQuery";
            "EstablishmentName" = $Establishment;
        }
        Invoke-DbaSqlQuery -SqlInstance $SQLInstance -Database $DemoDatabase -Query $MyParameterizedQuery -SqlParameters $QueryParameters;
    }
}

function Get-Unsafe {
    Write-Verbose $MyInvocation.MyCommand; 
    $Establishments = @(
        "Simply Crepes",
        "Eddie O' and 0=0 UNION ALL select NULL,NULL,[Name] from sys.tables;--Briens");
    foreach ($Establishment in $Establishments) {
        $MyQuery = "Select LocId,FunctionUsed, [Name] from [dbo].[Establishments] where [Name] = '$Establishment';";
        Write-Verbose $MyQuery;
        Invoke-SQLCmd -ServerInstance $SQLInstance -Database $DemoDatabase -Query $MyQuery;
    }
}

function Get-Safely {
    Write-Verbose $MyInvocation.MyCommand; 
    $Establishments = @("Simply Crepes", "Eddie O' and 0=0 UNION ALL select NULL,NULL,[Name] from sys.tables;--Briens");
    $MyParameterizedQuery = "Select LocId,FunctionUsed, [Name] from [dbo].[Establishments] where [Name] = @EstablishmentName;"
    foreach ($Establishment in $Establishments) {
        $QueryParameters = @{
            "EstablishmentName" = $Establishment;
        }
        Invoke-DbaSqlQuery -SqlInstance $SQLInstance -Database $DemoDatabase -Query $MyParameterizedQuery -SqlParameters $QueryParameters;
    }

}

Invoke-Naive;
Read-Host "Ready...";
Invoke-WithInjection;
Read-Host "Ready...";
Invoke-Safely;
Read-Host "Ready...";
Get-Unsafe;
Write-Output '-----';
Read-host "Ready...";
Get-Safely;

<#
Andy Levy
@alevyinroc
https://therestisjustcode.wordpress.com/
#>

