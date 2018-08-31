#region Demo 1 - "View" file example
$replacements = [ordered]@{
    #starting <value> = LIKE '<value>%'
    'starting([ ]{1,})(''\w{1,})'                = "LIKE`$1`$2%"
    #starting with '<value>' = LIKE '<value>%'
    'starting([ ]{1,})with([ ]{1,})(''\w{1,})'   = "LIKE`$2`$3%"

    #SET GENERATOR <name> to <value> -> ALTER SEQUENCE <name> MINVALUE <value>
    '(SET)(\s)(GENERATOR)(\s)(.*)(\s)(?=to)(to)' = "ALTER`$2SEQUENCE dbo.[`$5] RESTART WITH"
    #add GO for CREATE/ALTER SEQUENCE
    ';((\r\n){1,})(CREATE|ALTER)'                = ";`r`nGO`r`n`r`n`$3"

    #Views file only
    '(\bCREATE OR ALTER VIEW\b)([ ])(\w{1,})'    = "IF OBJECT_ID('dbo.`$3', 'V') IS NOT NULL`r`n`tDROP VIEW dbo.`$3`r`nGO`r`nCREATE VIEW`$2dbo.`$3"
    '(\*\/\r\n\bCREATE VIEW\b)([ ])(\w{1,})'     = "*/`r`nIF OBJECT_ID('dbo.`$3', 'V') IS NOT NULL`r`n`tDROP VIEW dbo.`$3`r`nGO`r`nCREATE VIEW`$2dbo.`$3"

}
Set-Expression -Pattern $replacements -Multiline -Overwrite -Encoding "UTF8" -FullName ".\Demo\View.sql"
#endregion

#region Demo 2 - "Stored Procedure" file example
#Generate regexp leveraging on SQL Server Metadata
$replacements = [ordered]@{
    #starting <value> = LIKE '<value>%'
    'starting([ ]{1,})(''\w{1,})'                = "LIKE`$1`$2%"
    #starting with '<value>' = LIKE '<value>%'
    'starting([ ]{1,})with([ ]{1,})(''\w{1,})'   = "LIKE`$2`$3%"

    #SET GENERATOR <name> to <value> -> ALTER SEQUENCE <name> MINVALUE <value>
    '(SET)(\s)(GENERATOR)(\s)(.*)(\s)(?=to)(to)' = "ALTER`$2SEQUENCE dbo.[`$5] RESTART WITH"
    #add GO for CREATE/ALTER SEQUENCE
    ';((\r\n){1,})(CREATE|ALTER)'                = ";`r`nGO`r`n`r`n`$3"

    #Views file only
    '(\bCREATE OR ALTER VIEW\b)([ ])(\w{1,})'    = "IF OBJECT_ID('dbo.`$3', 'V') IS NOT NULL`r`n`tDROP VIEW dbo.`$3`r`nGO`r`nCREATE VIEW`$2dbo.`$3"
    '(\*\/\r\n\bCREATE VIEW\b)([ ])(\w{1,})'     = "*/`r`nIF OBJECT_ID('dbo.`$3', 'V') IS NOT NULL`r`n`tDROP VIEW dbo.`$3`r`nGO`r`nCREATE VIEW`$2dbo.`$3"

    # #Only SPs!!!! And need to be the last replace!
    '(\bCREATE OR ALTER PROCEDURE\b)([ ])(\w{1,})'        = "IF OBJECT_ID('dbo.`$3', 'P') IS NOT NULL`r`n`tDROP PROCEDURE dbo.`$3`r`nGO`r`nCREATE PROCEDURE`$2dbo.`$3"

    'declare variable '                                   = "DECLARE @"

}
Set-Expression -Pattern $replacements -Multiline -Overwrite -Encoding "UTF8" -FullName ".\Demo\StoredProcedure.sql"
#endregion

#region Demo 3 - "Trigger" file example
$replacements = [ordered]@{
    #starting <value> = LIKE '<value>%'
    'starting([ ]{1,})(''\w{1,})'                = "LIKE`$1`$2%"
    #starting with '<value>' = LIKE '<value>%'
    'starting([ ]{1,})with([ ]{1,})(''\w{1,})'   = "LIKE`$2`$3%"

    #SET GENERATOR <name> to <value> -> ALTER SEQUENCE <name> MINVALUE <value>
    '(SET)(\s)(GENERATOR)(\s)(.*)(\s)(?=to)(to)' = "ALTER`$2SEQUENCE dbo.[`$5] RESTART WITH"
    #add GO for CREATE/ALTER SEQUENCE
    ';((\r\n){1,})(CREATE|ALTER)'                = ";`r`nGO`r`n`r`n`$3"

    #Views file only
    '(\bCREATE OR ALTER VIEW\b)([ ])(\w{1,})'    = "IF OBJECT_ID('dbo.`$3', 'V') IS NOT NULL`r`n`tDROP VIEW dbo.`$3`r`nGO`r`nCREATE VIEW`$2dbo.`$3"
    '(\*\/\r\n\bCREATE VIEW\b)([ ])(\w{1,})'     = "*/`r`nIF OBJECT_ID('dbo.`$3', 'V') IS NOT NULL`r`n`tDROP VIEW dbo.`$3`r`nGO`r`nCREATE VIEW`$2dbo.`$3"

    #Triggers only
    '(\bCREATE OR ALTER TRIGGER\b)([ ])(\w{1,})'                             = "IF OBJECT_ID('dbo.`$3', 'TR') IS NOT NULL`r`n`tDROP TRIGGER dbo.`$3`r`nGO`r`nCREATE TRIGGER`$2dbo.`$3"
    '(IF )(\()(new\.)(id is null or )(new\.)(id = 0)(\))'                    = "`$1EXISTS`$2SELECT 1 FROM INSERTED WHERE `$4`$6)"
    '(IF )(\()(new\.)(pid is null)(\))'                                      = "`$1EXISTS`$2SELECT 1 FROM INSERTED WHERE `$4)"
    '(IF )(\()(new\.)(id is null)(\))'                                       = "`$1EXISTS`$2SELECT 1 FROM INSERTED WHERE `$4)"
    '\bNEW.\b'                                                               = "inserted."

}
Set-Expression -Pattern $replacements -Multiline -Overwrite -Encoding "UTF8" -FullName ".\Demo\Trigger.sql"
#endregion

#region Demo 4 - Multiple files example
#Generate regexp leveraging on SQL Server Metadata
$replacements = [ordered]@{
    #starting <value> = LIKE '<value>%'
    'starting([ ]{1,})(''\w{1,})'                                                                                                                                 = "LIKE`$1`$2%"
    #starting with '<value>' = LIKE '<value>%'
    'starting([ ]{1,})with([ ]{1,})(''\w{1,})'                                                                                                                    = "LIKE`$2`$3%"

    #CREATE GENERATOR
    #SET GENERATOR <name> to <value> -> ALTER SEQUENCE <name> MINVALUE <value>
    '(SET)(\s)(GENERATOR)(\s)(.*)(\s)(?=to)(to)'                                                                                                                  = "ALTER`$2SEQUENCE dbo.[`$5] RESTART WITH"
    #add GO for CREATE/ALTER SEQUENCE
    ';((\r\n){1,})(CREATE|ALTER)'                                                                                                                                 = ";`r`nGO`r`n`r`n`$3"

    #Views file only
    '(\bCREATE OR ALTER VIEW\b)([ ])(\w{1,})'                                                                                                                     = "IF OBJECT_ID('dbo.`$3', 'V') IS NOT NULL`r`n`tDROP VIEW dbo.`$3`r`nGO`r`nCREATE VIEW`$2dbo.`$3"
    '(\*\/\r\n\bCREATE VIEW\b)([ ])(\w{1,})'                                                                                                                      = "*/`r`nIF OBJECT_ID('dbo.`$3', 'V') IS NOT NULL`r`n`tDROP VIEW dbo.`$3`r`nGO`r`nCREATE VIEW`$2dbo.`$3"

    # #Only SPs!!!! And need to be the last replace!
    '(\bCREATE OR ALTER PROCEDURE\b)([ ])(\w{1,})'        = "IF OBJECT_ID('dbo.`$3', 'P') IS NOT NULL`r`n`tDROP PROCEDURE dbo.`$3`r`nGO`r`nCREATE PROCEDURE`$2dbo.`$3"

    'declare variable '                                   = "DECLARE @"

    '\bTYPE OF COLUMN Customers.COMPANY_NAME\b' = "NVARCHAR(100)"
    '\bTYPE OF COLUMN Customers.ID\b' = "INT"
    '\bTYPE OF COLUMN Customers.NAME\b' = "NVARCHAR(24)"
    '\bTYPE OF COLUMN V_Customers.COMPANY_NAME\b' = "NVARCHAR(100)"
    '\bTYPE OF COLUMN V_Customers.ID\b' = "INT"
    '\bTYPE OF COLUMN V_Customers.NAME\b' = "NVARCHAR(24)"

    #Triggers only
    '(\bCREATE OR ALTER TRIGGER\b)([ ])(\w{1,})'                             = "IF OBJECT_ID('dbo.`$3', 'TR') IS NOT NULL`r`n`tDROP TRIGGER dbo.`$3`r`nGO`r`nCREATE TRIGGER`$2dbo.`$3"
    '(IF )(\()(new\.)(id is null or )(new\.)(id = 0)(\))'                    = "`$1EXISTS`$2SELECT 1 FROM INSERTED WHERE `$4`$6)"
    '(IF )(\()(new\.)(pid is null)(\))'                                      = "`$1EXISTS`$2SELECT 1 FROM INSERTED WHERE `$4)"
    '(IF )(\()(new\.)(id is null)(\))'                                       = "`$1EXISTS`$2SELECT 1 FROM INSERTED WHERE `$4)"
    '\bNEW.\b'                                                               = "inserted."

    '(FOR )(\bCustomers\b)((.|\r\n){1,})(\bACTIVE BEFORE INSERT POSITION 0\b)(\r\n)(AS)(\r\n)(BEGIN)(\r\n)((.|\n){1,})(gen_id\()(\w{1,})((.|\r\n)*?)(?=end;)(.*)' = "ON `$2`$3INSTEAD OF INSERT`$3`$7`$8`$9`$10`$11`$12 `$3INSERT INTO `$2 (  ID, NAME, COMPANY_NAME ) `$3SELECT NEXT VALUE FOR dbo.`$14,  ID, NAME, COMPANY_NAME FROM INSERTED `$3 --`$13`$14`$15`$16`$17"
    '(FOR )(\bCustomers\b)((.|\r\n){1,})(\bACTIVE BEFORE UPDATE POSITION 0\b)(\r\n)(AS)(\r\n)(BEGIN)(\r\n)((.|\r\n){1,})((.|\r\n)*?)(?=end;)(.*)' = "ON `$2`$3INSTEAD OF UPDATE`$3`$7`$8`$9 `$3UPDATE `$2 `$3SET  ID = ID, NAME = NAME, COMPANY_NAME = COMPANY_NAME, `$10`$11 FROM INSERTED `$3 `$15"
}
Get-ChildItem ".\DDL\*.sql" | ForEach-Object {
    Set-Expression -Pattern $replacements -Multiline -Overwrite -Encoding "UTF8" -FullName $_.FullName
}
#endregion